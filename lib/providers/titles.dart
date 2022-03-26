import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';

class Title {
  int id;
  final String titleName;
  final String author;

  Title({required this.id, required this.titleName, required this.author});
}

class Titles with ChangeNotifier {
  final String _token;

  Titles(this._token);

  List<Title> _titles = [];

  List<Title> get titles {
    return [..._titles];
  }

  Title parseTitle(dynamic fetchedTitle) {
    return Title(
      id: fetchedTitle['id'],
      titleName: fetchedTitle['titleName'],
      author: fetchedTitle['author'],
    );
  }

  Future<void> fetchAndSetTitles() async {
    print('fetching titles Data');
    var url = Uri.parse('$API_URL/title');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    print(fetchedData);
    final List<Title> loadedTitles = [];
    fetchedData.forEach((fetchedTitle) {
      loadedTitles.add(parseTitle(fetchedTitle));
    });
    print(loadedTitles);
    _titles = loadedTitles;
    notifyListeners();
  }

  Future<void> addTitle(Title title) async {
    var url = Uri.parse('$API_URL/title');
    try {
      final response = await http.post(url,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({
            'titleName': title.titleName,
            'author': title.author,
            'cover': 'www',
          }));
      print(response.body);
      final fetchedData = json.decode(response.body);
      _titles.add(parseTitle(fetchedData));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteTitle(int titleId) async {
    var url = Uri.parse('$API_URL/title/$titleId');
    try {
      final response = await http.delete(url);
      _titles.removeWhere((element) => element.id == titleId);
      print(response.body);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
