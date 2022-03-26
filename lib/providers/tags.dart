import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';

class Tag {
  final String id;
  final int numberOfHighlights;

  Tag({required this.id, required this.numberOfHighlights});

  factory Tag.fromJson(Map<String, dynamic> parsedJson) {
    print('parsing tag');
    return Tag(
      id: parsedJson['id'],
      numberOfHighlights: parsedJson['numberOfHighlights'],
    );
  }
}

class Tags with ChangeNotifier {
  final String _token;

  Tags(this._token);

  List<Tag> _tags = [];

  List<Tag> get tags {
    return [..._tags];
  }

  List<String> get stringTags {
    return tags.map((t) => t.id).toList();
  }

  Future<void> fetchTags() async {
    print('fetching tags Data');
    var url = Uri.parse('$API_URL/tag');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    final List<Tag> loadedTags = [];
    fetchedData.forEach((fetchedTag) {
      loadedTags.add(Tag(
          id: fetchedTag['id'],
          numberOfHighlights: fetchedTag['numberOfHighlights']));
    });
    _tags = loadedTags;
    notifyListeners();
  }

  Future<void> deleteTag(String tagId) async {
    var url = Uri.parse('$API_URL/tag/$tagId');
    try {
      final response = await http.delete(url);
      _tags.removeWhere((element) => element.id == tagId);
      print(response.body);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
