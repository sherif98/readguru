import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readguru/providers/common.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/tags.dart';

class Highlights with ChangeNotifier {
  final String _token;

  List<Highlight> _highlights = [];

  Highlights(this._token);

  List<Highlight> get highlights {
    if (_highlights.isEmpty) fetchAndSetHighlights();
    return [..._highlights];
  }

  Future<void> fetchAndSetHighlights() async {
    print('fetchAndSetHighlights()');
    var url = Uri.parse('$API_URL/highlight');
    final response = await http.get(url, headers: {
      'Authorization': _token,
    });
    print(response.statusCode);
    print(response.body);
    final fetchedData = json.decode(response.body) as List<dynamic>;
    print(fetchedData);
    final List<Highlight> loadedHighlights = [];
    fetchedData.forEach((fetchedHighlight) {
      loadedHighlights.add(Highlight.fromJson(fetchedHighlight));
    });
    _highlights = loadedHighlights;
    print(_highlights);
    // TODO empty highlights causes infinite rescursive calls
    notifyListeners();
  }

  Future<void> addHighlight(Highlight highlight) async {
    var url = Uri.parse('$API_URL/title/${highlight.titleId}/highlight');
    print(url);
    try {
      final response = await http.post(url,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            'Authorization': _token,
          },
          body: json.encode({
            'highlightText': highlight.data,
          }));
      print(response.body);
      final fetchedData = json.decode(response.body);
      _highlights.add(Highlight.fromJson(fetchedData));
      notifyListeners();
      print(_highlights);
    } catch (error) {
      print(error);
    }
  }

  // TODO move to highlight.dart?
  Future<void> deleteHighlight(int highlightId) async {
    var url = Uri.parse('$API_URL/highlight/$highlightId');
    try {
      final response = await http.delete(url, headers: {
        'Authorization': _token,
      });
      print(response.body);
      _highlights.removeWhere((element) => element.id == highlightId);
      notifyListeners();
      print(_highlights);
    } catch (error) {
      print(error);
    }
  }

  Future<List<Highlight>> fetchDailyReviewHighlights() async {
    var url = Uri.parse('$API_URL/highlights/1/daily');
    try {
      final response = await http.get(url, headers: {
        'Authorization': _token,
      });
      print(response.body);
      final fetchedData = json.decode(response.body) as List<dynamic>;
      print('here');
      print(fetchedData);
      final List<Highlight> loadedHighlights = [];
      fetchedData.forEach((fetchedHighlight) {
        loadedHighlights.add(Highlight(
          id: fetchedHighlight['id'],
          titleName: fetchedHighlight['titlename'],
          titleId: fetchedHighlight['titleid'],
          data: fetchedHighlight['highlighttext'],
          author: fetchedHighlight['title']['author'],
          tags: fetchedHighlight['tags'],
          isFavorite: fetchedHighlight['favorite'],
        ));
      });
      notifyListeners();
      return loadedHighlights;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<Highlight>> getHighlightsForTitle(int titleId) async {
    // if (_highlights.isEmpty) fetchAndSetHighlights();
    // return _highlights.where((element) => element.titleName == title).toList();

    var url = Uri.parse('$API_URL/highlight?titleq=$titleId');
    try {
      final response = await http.get(url, headers: {
        'Authorization': _token,
      });
      print(response.body);
      final fetchedData = json.decode(response.body) as List<dynamic>;
      print(fetchedData);
      final List<Highlight> loadedHighlights = [];
      fetchedData.forEach((fetchedHighlight) {
        loadedHighlights.add(Highlight.fromJson(fetchedHighlight));
      });
      notifyListeners();
      return loadedHighlights;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<Highlight>> getHighlightsForTag(String tagId) async {
    // if (_highlights.isEmpty) fetchAndSetHighlights();
    // return _highlights.where((element) => element.titleName == title).toList();

    var url = Uri.parse('$API_URL/highlight?tagq=$tagId');
    try {
      final response = await http.get(url, headers: {
        'Authorization': _token,
      });
      print(response.body);
      final fetchedData = json.decode(response.body) as List<dynamic>;
      print(fetchedData);
      final List<Highlight> loadedHighlights = [];
      fetchedData.forEach((fetchedHighlight) {
        loadedHighlights.add(Highlight.fromJson(fetchedHighlight));
      });
      notifyListeners();
      return loadedHighlights;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
