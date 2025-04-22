import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:q_tec_task_app_/controller/api_service/memes_list.dart';
import 'package:q_tec_task_app_/model/product_response_model.dart';

class HomeController extends GetxController {
  List<ProductsResponseModel> memesList = [];
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  List<ProductsResponseModel> searchList = [];

  getMemes() async {
    isLoading.value = true;
    memesList = await MemesListService.memesListService();
    searchList.addAll(memesList);
    isLoading.value = false;
  }

  searchFun({required String searchText}) async {
    isLoading.value = true;
    searchList = memesList
        .where((value) =>
            value.title?.toLowerCase().contains(searchText.toLowerCase()) ??
            false)
        .toList();
    isLoading.value = false;
  }

  @override
  void onInit() {
    getMemes();
    super.onInit();
  }
}
