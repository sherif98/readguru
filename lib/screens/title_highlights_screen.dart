import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/widgets/highlight.dart';

class TitleHighlightsScreen extends StatefulWidget {
  static const routeName = '/title-detail';
  const TitleHighlightsScreen({Key? key}) : super(key: key);

  @override
  _TitleHighlightsScreenState createState() => _TitleHighlightsScreenState();
}

class _TitleHighlightsScreenState extends State<TitleHighlightsScreen> {
  @override
  Widget build(BuildContext context) {
    final String titleName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(titleName),
      ),
      body: Consumer<Highlights>(
        builder: (ctx, data, _) {
          final highlights = data.getHighlightsForTitle(titleName);
          return ListView.builder(
            itemCount: highlights.length,
            itemBuilder: (ctx, idx) => Highlight(
              highlights[idx].id,
              highlights[idx].title,
              highlights[idx].data,
            ),
          );
        },
      ),
    );
  }
}
