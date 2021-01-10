import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:login/src/models/product_model.dart';

class ProductProvider {
  final String _url = 'https://flutter-project-e22eb-default-rtdb.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final String url = '$_url/products.json';
    
    final http.Response resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}