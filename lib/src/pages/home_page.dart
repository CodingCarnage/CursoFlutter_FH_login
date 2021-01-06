import 'package:flutter/material.dart';

import 'package:login/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            Divider(),
            Text('Password: ${bloc.password}')
          ],
        ),
      ),
    );
  }
}
