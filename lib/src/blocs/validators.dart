import 'dart:async';

class Validators {
  final StreamTransformer<String, String> validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6 || password.length == 0) {
        sink.add(password);
      } else {
        sink.addError('Password is too short');
      }
    }
  );

  final StreamTransformer<String, String> validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email) || email.length == 0) {
        sink.add(email);
      } else {
        sink.addError('Not a valid email');
      }
    }
  );
}