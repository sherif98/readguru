import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';

class Auth with ChangeNotifier {
  String _token = "";

  String get token {
    return _token;
  }

  Future<String> fetchToken(User user) async {
    var jwt = await user.getIdToken();
    _token = 'Bearer $jwt';
    print(_token);
    var url = Uri.parse('$API_URL/user');
    final response = await http.post(url, headers: {
      // 'content-type': 'application/json',
      // 'accept': 'application/json',
      'Authorization': _token,
    });
    print(response.statusCode);
    notifyListeners();
    return _token;
  }
}
