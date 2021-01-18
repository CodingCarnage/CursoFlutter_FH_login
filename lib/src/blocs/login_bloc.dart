import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:login/src/blocs/validators.dart';


class LoginBloc with Validators {
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  
  // Get values from the stream.
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get fromValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  
  // Set values to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Get last value from stream.
  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() { 
    _emailController?.close();
    _passwordController?.close();
  }
}