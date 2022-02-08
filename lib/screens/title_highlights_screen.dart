import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/providers/titles.dart' as titles;
import 'package:readguru/widgets/highlight_card.dart';

class TitleHighlightsScreen extends StatefulWidget {
  static const routeName = '/title-detail';
  const TitleHighlightsScreen({Key? key}) : super(key: key);

  @override
  _TitleHighlightsScreenState createState() => _TitleHighlightsScreenState();
}

class _TitleHighlightsScreenState extends State<TitleHighlightsScreen> {
  @override
  Widget build(BuildContext context) {
    final titles.Title title =
        ModalRoute.of(context)!.settings.arguments as titles.Title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title.titleName),
      ),
      body: FutureBuilder(
        future: Provider.of<Highlights>(context, listen: false)
            .getHighlightsForTitle(title.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred ${snapshot.error}'),
            );
          }
          print(snapshot.data);
          final highlights = snapshot.data as List<Highlight>;
          return ListView.builder(
            itemCount: highlights.length,
            itemBuilder: (ctx, idx) => HighlightCard(
              highlights[idx].id,
              highlights[idx].titleName,
              highlights[idx].data,
            ),
          );
        },
      ),
    );
  }
}
