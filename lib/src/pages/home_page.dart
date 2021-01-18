import 'package:flutter/material.dart';

import 'package:optimized_cached_image/optimized_cached_image.dart';

import 'package:login/src/blocs/provider.dart';

import 'package:login/src/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ProductsBloc productsBloc = Provider.productsBloc(context);
    productsBloc.loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _createLists(productsBloc),
      floatingActionButton: _createFloatingActionButton(context),
    );
  }

  FloatingActionButton _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product').then((value) {
        setState(() {});
      }),
    );
  }

  Widget _createLists(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final List<ProductModel> products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) =>
                _createItem(context, products[index], productsBloc),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(
      BuildContext context, ProductModel product, ProductsBloc productsBloc) {
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
      onDismissed: (DismissDirection direction) {
        productsBloc.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (product.imageUrl == null)
                ? Image(image: AssetImage('assets/images/no-image.png'))
                : OptimizedCacheImage(
                    imageUrl: product.imageUrl,
                    imageBuilder: (context, imageProvider) {
                      return Image(image: imageProvider);
                    },
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
            ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () {
                  Navigator.pushNamed(context, 'product', arguments: product)
                      .then((value) {
                    setState(() {});
                  });
                })
          ],
        ),
      ),
    );
  }
}
