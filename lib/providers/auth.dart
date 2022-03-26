import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _token = "";

  String get token {
    return _token;
  }

  Future<String> fetchToken(User data) async {
    _token = await data.getIdToken();
    notifyListeners();
    return _token;
  }
}
