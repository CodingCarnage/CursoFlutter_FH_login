import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyBMk3pyb6jDxqQ12fNW_b9FrHDxhAVLbB8';

  Future newUser(String email, String password) async {
    final Map<String, Object> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final http.Response response = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    print(decodedResponse);

    if (decodedResponse.containsKey('idToken')) {
      // TODO: Save token in storage.
      return {
        'ok' : true,
        'token' : decodedResponse['idToken']
      };
    } else {
      return {
        'ok' : false,
        'message' : decodedResponse['error']['message']
      };
    }
  }
}
