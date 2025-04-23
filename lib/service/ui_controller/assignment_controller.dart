import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:q_tec_task_app_/internet_checker/internet_checker.dart';
import 'package:q_tec_task_app_/model/all_product_model.dart';
import 'package:q_tec_task_app_/service/controller/service_controller/prodcut_service_controller.dart';

enum SortOption { none, priceLowToHigh, ratingHighToLow }

class AssingmentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isOffline = false.obs;

  List<AllProductModel> allFetchedProducts = <AllProductModel>[];
  RxList<AllProductModel> allProductList = <AllProductModel>[].obs;

  Rx<SortOption> selectedSortOption = SortOption.none.obs;

  int currentPage = 1;
  final int perPage = 10;
  String searchQuery = '';

  bool get hasMore => currentPage * perPage < _getFilteredAndSortedList().length;

  @override
  void onInit() {
    super.onInit();
    getInitialProduct();
  }

  Future<void> getInitialProduct() async {
    isLoading.value = true;

    if (!await ConnectionChecker.checkConnection()) {
      isOffline.value = true;
      EasyLoading.show(status: "No internet. Loading offline data...");

      var box = Hive.box<AllProductModel>('productBox');
      allFetchedProducts = box.values.toList();
      await Future.delayed(const Duration(milliseconds: 300));
      _updatePaginatedList();

      EasyLoading.dismiss();

      Get.snackbar(
        "Offline Mode",
        "You're seeing cached data.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      isLoading.value = false;
      return;
    }

    try {
      isOffline.value = false;

      allFetchedProducts = await ProductService.fetchAllProduct();
      _updatePaginatedList();
    } catch (e) {
      EasyLoading.showError("Error loading products: $e");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  void _updatePaginatedList() {
    final filtered = _getFilteredAndSortedList();
    int endIndex = currentPage * perPage;
    allProductList.value = filtered.take(endIndex).toList();
  }

  List<AllProductModel> _getFilteredAndSortedList() {
    List<AllProductModel> list = allFetchedProducts;

    // Filter
    if (searchQuery.isNotEmpty) {
      list = list
          .where((product) =>
      product.title?.toLowerCase().contains(searchQuery.toLowerCase()) ??
          false)
          .toList();
    }

    // Sort
    switch (selectedSortOption.value) {
      case SortOption.priceLowToHigh:
        list.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case SortOption.ratingHighToLow:
        list.sort((b, a) =>
            (a.rating?.rate ?? 0).compareTo(b.rating?.rate ?? 0));
        break;
      case SortOption.none:
        break;
    }

    return list;
  }

  void loadNextPage() {
    if (isOffline.value) return;
    if (hasMore) {
      currentPage++;
      _updatePaginatedList();
    }
  }

  void updateSearch(String query) {
    searchQuery = query;
    currentPage = 1;
    _updatePaginatedList();
  }

  void updateSort(SortOption option) {
    selectedSortOption.value = option;
    currentPage = 1;
    _updatePaginatedList();
  }
}
