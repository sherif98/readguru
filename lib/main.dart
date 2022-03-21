import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/providers/tags.dart';
import 'package:readguru/providers/titles.dart';
import 'package:readguru/screens/add_text_highlight_screen.dart';
import 'package:readguru/screens/add_title_screen.dart';
import 'package:readguru/screens/daily_highlights_review_screen.dart';
import 'package:readguru/screens/highlights_feed_screen.dart';
import 'package:readguru/screens/list_tags_screen.dart';
import 'package:readguru/screens/list_titles_screen.dart';
import 'package:readguru/screens/tabs_screen.dart';
import 'package:readguru/screens/tag_highlights_screen.dart';
import 'package:readguru/screens/title_highlights_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Highlights(),
        ),
        ChangeNotifierProvider(
          create: (_) => Titles(),
        ),
        ChangeNotifierProvider(
          create: (_) => Tags(),
        ),
      ],
      child: MaterialApp(
        title: 'Readguru',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        home: TabsScreen(),
        routes: {
          HighlighsFeedScreen.routeName: (_) => HighlighsFeedScreen(),
          AddTextHighlightScreen.routeName: (_) => AddTextHighlightScreen(),
          AddTitleScreen.routeName: (_) => AddTitleScreen(),
          ListTitlesScreen.routeName: (_) => ListTitlesScreen(),
          ListTagsScreen.routeName: (_) => ListTagsScreen(),
          TitleHighlightsScreen.routeName: (_) => TitleHighlightsScreen(),
          TagHighlightsScreen.routeName: (_) => TagHighlightsScreen(),
          DailyHighlightsReviewScreen.routeName: (_) =>
              DailyHighlightsReviewScreen(),
        },
      ),
    );
  }
}
