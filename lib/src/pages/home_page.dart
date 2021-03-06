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
      ),
      onDismissed: (DismissDirection direction) {
        productsBloc.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (product.imageUrl == null)
                ? GestureDetector(
                    child:
                        Image(image: AssetImage('assets/images/no-image.png')),
                    onTap: () {
                      Navigator.pushNamed(context, 'product',
                              arguments: product)
                          .then((value) {
                        setState(() {});
                      });
                    },
                  )
                : OptimizedCacheImage(
                    imageUrl: product.imageUrl,
                    imageBuilder: (context, imageProvider) {
                      return GestureDetector(
                        child: Image(
                          image: imageProvider,
                          height: 300.0,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'product',
                                  arguments: product)
                              .then((value) {
                            setState(() {});
                          });
                        },
                      );
                    },
                    placeholder: (context, url) => Image(
                      image: AssetImage('assets/images/jar-loading.gif'),
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
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
              },
            )
          ],
        ),
      ),
    );
  }
}
