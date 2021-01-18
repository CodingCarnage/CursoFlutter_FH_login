import 'package:flutter/material.dart';

import 'package:login/src/blocs/login_bloc.dart';
export 'package:login/src/blocs/login_bloc.dart';
import 'package:login/src/blocs/products_bloc.dart';
export 'package:login/src/blocs/products_bloc.dart';

class Provider extends InheritedWidget {
  
  final LoginBloc loginBloc = new LoginBloc();
  final ProductsBloc _productsBloc = new ProductsBloc();
  
  static Provider _instance;

  factory Provider ({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductsBloc productsBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}