import 'dart:async';

class LoginBloc {
  final StreamController _emailController = StreamController<String>.broadcast();
  final StreamController _passwordController = StreamController<String>.broadcast();
  
  // Get values from the stream.
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  // Set values to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void dispose() { 
    _emailController?.close();
    _passwordController?.close();
  }
}