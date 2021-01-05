import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Container topBackground = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );

    final circle = Container(
      width: size.height * 0.1125,
      height: size.height * 0.1125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        topBackground,
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -20.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 112.0, right: 45.0, child: circle),
        Positioned(bottom: -30.0, left: -20.0, child: circle),
        Positioned(bottom: 50.0, left: 130.0, child: circle),
        Positioned(top: -10.0, left: 150.0, child: circle),
        Container(
          padding: const EdgeInsets.only(top: 70.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: size.height * 0.1125,
              ),
              SizedBox(height: 10.0, width: double.infinity),
              Text(
                'Cesar López',
                style: Theme.of(context).textTheme.headline5.apply(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Log In',style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 50.0),
                _createEmail(),
                const SizedBox(height: 20.0),
                _createPassword(),
                const SizedBox(height: 20.0),
                _createButton(),
              ],
            ),
          ),
          Text('Forgot password?'),
          const SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _createEmail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        cursorColor: Colors.deepPurple,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: Colors.deepPurple),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'example@email.com',
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.deepPurple)
        ),
      ),
    );
  }
  
  Widget _createPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: 	true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: Colors.deepPurple),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.deepPurple)
        ),
      ),
    );
  }

  Widget _createButton() {
    return RaisedButton(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Log In'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
