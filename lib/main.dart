import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/screens/highlights_feed_screen.dart';
import 'package:readguru/screens/tabs_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Readguru',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        home: TabsScreen(),
        routes: {
          HighlighsFeedScreen.routeName: (ctx) => HighlighsFeedScreen(),
        },
      ),
    );
  }
}
