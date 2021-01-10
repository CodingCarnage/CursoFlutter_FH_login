import 'package:flutter/material.dart';

import 'package:login/src/models/product_model.dart';

import 'package:login/src/providers/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static final ProductProvider productProvider = new ProductProvider();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _createLists(),
      floatingActionButton: _createFloatingActionButton(context),
    );
  }

  FloatingActionButton _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _createLists() {
    return FutureBuilder(
      future: productProvider.loadProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
