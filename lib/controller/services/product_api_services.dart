
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';


class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/';
  static const String _productEndPoint = 'products';
  static const String _categoryEndPoint = 'products/categories';

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl$_productEndPoint"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<dynamic>> getCategory() async {
    final response = await http.get(Uri.parse(_baseUrl+_categoryEndPoint));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load products');
    }
  }

}
