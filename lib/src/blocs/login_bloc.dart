import 'dart:async';

import 'package:login/src/blocs/validators.dart';

class LoginBloc with Validators {
  final StreamController _emailController = StreamController<String>.broadcast();
  final StreamController _passwordController = StreamController<String>.broadcast();
  
  // Get values from the stream.
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  // Set values to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void dispose() { 
    _emailController?.close();
    _passwordController?.close();
  }
}