import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:login/src/models/product_model.dart';

import 'package:login/src/providers/product_provider.dart';

class ProductsBloc {
  final BehaviorSubject<List<ProductModel>> _productsController = new BehaviorSubject<List<ProductModel>>();
  final BehaviorSubject<bool> _loadingController = new BehaviorSubject<bool>();

  final ProductProvider _productProvider = new ProductProvider();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  void loadProducts() async {
    final List<ProductModel> products = await _productProvider.loadProducts();
    _productsController.sink.add(products);
  }

  void addProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.createProduct(product);
    _loadingController.sink.add(false);
  }

  Future<String> uploadImage(File image) async {
    _loadingController.sink.add(true);
    final imageUrl = await _productProvider.uploadImage(image);
    _loadingController.sink.add(false);
    return imageUrl;
  }

  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productProvider.editProduct(product);
    _loadingController.sink.add(false);
  }

  void deleteProduct(String id) async {
    await _productProvider.deleteProduct(id);
  }

  void dispose() {
    _productsController?.close();
    _loadingController?.close();
  }
}