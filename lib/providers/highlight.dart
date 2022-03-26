import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';
import 'package:readguru/providers/tags.dart';

class Highlight with ChangeNotifier {
  int id;
  final String data;
  final int titleId;
  final String titleName;
  final String author;
  List<String> tags;
  bool isFavorite;

  Highlight({
    required this.id,
    required this.data,
    required this.titleId,
    required this.titleName,
    required this.author,
    required this.tags,
    required this.isFavorite,
  });

  factory Highlight.fromJson(Map<String, dynamic> parsedJson) {
    final List<String> tags = parsedJson['tags']
        .map((t) => Tag.fromJson(t))
        .map((t) => t.id)
        .toList()
        .cast<String>();
    return Highlight(
      id: parsedJson['id'],
      titleName: parsedJson['title']['titleName'],
      titleId: parsedJson['titleId'],
      data: parsedJson['highlightText'],
      author: parsedJson['title']['author'],
      tags: tags,
      isFavorite: parsedJson['favorite'],
    );
  }

  Future<void> toggleFavoriteStatus(String token) async {
    var url = Uri.parse('$API_URL/highlight/$id/favorite');
    await http.patch(url);
    print('highlight favorite toggled');
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> unTagHighlight(String tagId) async {
    var url = Uri.parse('$API_URL/highlight/$id/tag');
    final response = await http.delete(url,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encode({
          'tag': tagId,
        }));
    print(response.body);
    final fetchedData = json.decode(response.body);
    this.tags = Highlight.fromJson(fetchedData).tags;
    print('highlight tag deleted');
    notifyListeners();
  }

  Future<void> tagHighlight(String tagId) async {
    var url = Uri.parse('$API_URL/highlight/$id/tag');
    final response = await http.post(url,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encode({
          'tag': tagId,
        }));
    print(response.body);
    final fetchedData = json.decode(response.body);
    this.tags = Highlight.fromJson(fetchedData).tags;
    print('highlight tagged');
    notifyListeners();
  }
}
