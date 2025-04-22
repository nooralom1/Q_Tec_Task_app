import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:q_tec_task_app_/model/product_response_model.dart';

class MemesListService {
  static Future<List<ProductsResponseModel>> memesListService() async {
    try {
      Response response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        ProductsResponseModel data =
            ProductsResponseModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log("error: $e");
    }
    return [];
  }
}
