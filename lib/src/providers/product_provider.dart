import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:login/src/models/product_model.dart';

class ProductProvider {
  final String _url =
      'https://flutter-project-e22eb-default-rtdb.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final String url = '$_url/products.json';

    final http.Response resp =
        await http.post(url, body: productModelToJson(product));

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

    decodedData.forEach((String id, dynamic product) {
      final ProductModel productTemp = ProductModel.fromJson(product);
      productTemp.id = id;

      products.add(productTemp);
    });

    return products;
  }

  Future<int> deleteProduct(String id) async {
    final String url = '$_url/products/$id.json';
    final http.Response resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  Future<bool> editProduct(ProductModel product) async {
    final String url = '$_url/products/${product.id}.json';

    final http.Response resp =
        await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<String> uploadImage(File image) async {
    final Uri url = Uri.parse(
        'https://api.cloudinary.com/v1_1/codingcarnage/image/upload?upload_preset=xmpblnv1');
    final List<String> mimeType = mime(image.path).split('/');

    final http.MultipartRequest imageUploadRequest =
        http.MultipartRequest('POST', url);

    final http.MultipartFile file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(
        mimeType[0],
        mimeType[1]
      )
    );

    imageUploadRequest.files.add(file);

    final http.StreamedResponse streamedResponse = await imageUploadRequest.send();
    final http.Response resp = await http.Response.fromStream(streamedResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something went wrong.');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
