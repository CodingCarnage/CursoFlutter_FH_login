import 'package:flutter/material.dart';

import 'package:login/src/blocs/provider.dart';

import 'package:login/src/preferences/user_preferences.dart';

import 'package:login/src/pages/login_page.dart';
import 'package:login/src/pages/home_page.dart';
import 'package:login/src/pages/product_page.dart';
import 'package:login/src/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserPreferences prefs = new UserPreferences();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'product' : (BuildContext context) => ProductPage(),
          'signup' : (BuildContext context) => SignUpPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
