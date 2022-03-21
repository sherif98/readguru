import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/providers/tags.dart';
import 'package:readguru/widgets/highlight_card.dart';

class TagHighlightsScreen extends StatelessWidget {
  static const routeName = '/tag-detail';

  const TagHighlightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tag tag = ModalRoute.of(context)!.settings.arguments as Tag;
    return Scaffold(
      appBar: AppBar(
        title: Text(tag.id),
      ),
      body: FutureBuilder(
        future: Provider.of<Highlights>(context, listen: false)
            .getHighlightsForTag(tag.id),
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
            itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
              value: highlights[idx],
              child: HighlightCard(),
            ),
          );
        },
      ),
    );
  }
}
