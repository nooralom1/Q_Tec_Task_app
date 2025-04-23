import 'dart:convert';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:q_tec_task_app_/model/all_product_model.dart';

class ProductService {
  static Future<List<AllProductModel>> fetchAllProduct() async {
    List<AllProductModel> allProduct = [];
    try {
      var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        for (var data in json) {
          allProduct.add(AllProductModel.fromJson(data));
        }

        var box = Hive.box<AllProductModel>('productBox');
        await box.clear();
        await box.addAll(allProduct);
      }

      return allProduct;
    } catch (e) {
      log("Error fetching products: $e");
      var box = Hive.box<AllProductModel>('productBox');
      return box.values.toList();
    }
  }
}
