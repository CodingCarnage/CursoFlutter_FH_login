import 'package:flutter/material.dart';

import 'package:login/src/blocs/login_bloc.dart';
export 'package:login/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance;

  factory Provider ({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, this.child}) : super(key: key, child: child);

  final Widget child;
  final LoginBloc loginBloc = LoginBloc();

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}