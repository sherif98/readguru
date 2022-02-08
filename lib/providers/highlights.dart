import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';
import 'package:readguru/providers/highlight.dart';

class Highlights with ChangeNotifier {
  List<Highlight> _highlights = [];

  List<Highlight> get highlights {
    if (_highlights.isEmpty) fetchAndSetHighlights();
    return [..._highlights];
  }

  Future<void> fetchAndSetHighlights() async {
    print('fetchingData');
    var url = Uri.parse('$API_URL/highlights/1');
    final response = await http.get(url);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    print(fetchedData);
    final List<Highlight> loadedHighlights = [];
    fetchedData.forEach((fetchedHighlight) {
      loadedHighlights.add(Highlight(
        id: fetchedHighlight['id'],
        titleName: fetchedHighlight['titleName'],
        titleId: fetchedHighlight['titleId'],
        data: fetchedHighlight['data'],
      ));
    });
    _highlights = loadedHighlights;
    print(_highlights);
    notifyListeners();
  }

  Future<void> addHighlight(Highlight highlight) async {
    var url = Uri.parse('$API_URL/highlights/1');
    try {
      final response = await http.post(url,
          body: json.encode({
            'highlightData': highlight.data,
            'titleId': highlight.titleId,
          }));
      print(response.body);
      _highlights.add(highlight);
      notifyListeners();
      print(_highlights);
    } catch (error) {
      print(error);
    }
  }

  Future<List<Highlight>> fetchDailyReviewHighlights() async {
    var url = Uri.parse('$API_URL/highlights/1/daily');
    try {
      final response = await http.get(url);
      print(response.body);
      final fetchedData = json.decode(response.body) as List<dynamic>;
      print('here');
      print(fetchedData);
      final List<Highlight> loadedHighlights = [];
      fetchedData.forEach((fetchedHighlight) {
        loadedHighlights.add(Highlight(
          id: fetchedHighlight['id'],
          titleName: fetchedHighlight['titleName'],
          titleId: fetchedHighlight['titleId'],
          data: fetchedHighlight['data'],
        ));
      });
      notifyListeners();
      return loadedHighlights;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<Highlight>> getHighlightsForTitle(String titleId) async {
    if (_highlights.isEmpty) fetchAndSetHighlights();
    // return _highlights.where((element) => element.titleName == title).toList();

    var url = Uri.parse('$API_URL/highlights/1?titleId=$titleId');
    try {
      final response = await http.get(url);
      print(response.body);
      final fetchedData = json.decode(response.body) as List<dynamic>;
      print('here');
      print(fetchedData);
      final List<Highlight> loadedHighlights = [];
      fetchedData.forEach((fetchedHighlight) {
        loadedHighlights.add(Highlight(
          id: fetchedHighlight['id'],
          titleName: fetchedHighlight['titleName'],
          titleId: fetchedHighlight['titleId'],
          data: fetchedHighlight['data'],
        ));
      });
      notifyListeners();
      return loadedHighlights;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
