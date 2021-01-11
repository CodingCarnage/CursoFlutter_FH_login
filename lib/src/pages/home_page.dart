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
          final List<ProductModel> products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) =>
                _createItem(context, products[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.5, horizontal: 7.5),
          child: FittedBox(
            alignment: Alignment.centerLeft, 
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      onDismissed: (direction) {
        // TODO: Delete product
      },
      child: ListTile(
        title: Text('${product.title} - ${product.value}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product'),
      ),
    );
  }
}
