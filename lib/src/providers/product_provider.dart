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

  Future<List<ProductModel>> loadProducts() async {
    final String url = '$_url/products.json';

    final http.Response resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List<ProductModel>();
    
    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((id, product) {
      final productTemp= ProductModel.fromJson(product);
      productTemp.id = id;

      products.add(productTemp);
    });

    return products;
  }
}
