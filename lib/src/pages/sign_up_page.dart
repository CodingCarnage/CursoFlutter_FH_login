import 'package:flutter/material.dart';

import 'package:login/src/blocs/provider.dart';
import 'package:login/src/providers/user_provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static final UserProvider userProvider = new UserProvider();

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
      decoration: const BoxDecoration(
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
        color: const Color.fromRGBO(255, 255, 255, 0.05),
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
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .apply(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);
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
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text('Sign Up', style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 50.0),
                _createEmail(bloc),
                const SizedBox(height: 20.0),
                _createPassword(bloc),
                const SizedBox(height: 20.0),
                _createButton(bloc),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            child: Text('Already have an account?, Log In'),
          ),
          const SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            cursorColor: Colors.deepPurple,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'example@email.com',
              labelText: 'Email',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            cursorColor: Colors.deepPurple,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Password',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.fromValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Log In'),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _signup(bloc, context) : null,
        );
      },
    );
  }

  _signup(LoginBloc bloc, BuildContext context) {
    userProvider.newUser(bloc.email, bloc.password);

    //Navigator.pushReplacementNamed(context, 'home');
  }
}
