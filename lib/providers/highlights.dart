import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/highlight.dart';

class Highlights with ChangeNotifier {
  List<Highlight> _highlights = [];

  List<Highlight> get highlights {
    return [..._highlights];
  }

  Future<void> fetchAndSetHighlights() async {
    print('fetchingData');
    var url = Uri.parse(
        'https://93c80r83j5.execute-api.us-east-1.amazonaws.com/dev/highlights/1');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    print(fetchedData);
    final List<Highlight> loadedHighlights = [];
    fetchedData.forEach((fetchedHighlight) {
      loadedHighlights.add(Highlight(
        id: fetchedHighlight['sortKey'],
        title: fetchedHighlight['title'],
        data: fetchedHighlight['highlightData'],
      ));
    });
    _highlights = loadedHighlights;
    notifyListeners();
  }

  Future<void> addHighlight(Highlight highlight) async {
    var url = Uri.parse(
        'https://93c80r83j5.execute-api.us-east-1.amazonaws.com/dev/highlights/1');
    try {
      final response = await http.post(url,
          body: json.encode({
            'highlightData': highlight.data,
            'titleName': highlight.title,
          }));
      print(response.body);
      _highlights.add(highlight);
      notifyListeners();
      print(_highlights);
    } catch (error) {
      print(error);
    }
  }
}
