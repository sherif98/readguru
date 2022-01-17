import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Title {
  final String id;
  final String titleName;
  final String author;

  Title({required this.id, required this.titleName, required this.author});
}

class Titles with ChangeNotifier {
  List<Title> _titles = [];

  List<Title> get titles {
    return [..._titles];
  }

  Future<void> fetchAndSetTitles() async {
    print('fetching titles Data');
    var url = Uri.parse(
        'https://93c80r83j5.execute-api.us-east-1.amazonaws.com/dev/title/1');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    print(fetchedData);
    final List<Title> loadedTitles = [];
    fetchedData.forEach((fetchedTitle) {
      loadedTitles.add(Title(
        id: fetchedTitle['sortKey'],
        titleName: fetchedTitle['titleName'],
        author: 'Sherif Eid',
      ));
    });
    _titles = loadedTitles;
    notifyListeners();
  }

  Future<void> addTitle(Title title) async {
    var url = Uri.parse(
        'https://93c80r83j5.execute-api.us-east-1.amazonaws.com/dev/title/1');
    try {
      final response = await http.post(url, body: json.encode(title.titleName));
      print(response.body);
      _titles.add(title);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
