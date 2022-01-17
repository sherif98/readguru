import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/widgets/highlight.dart';

class HighlighsFeedScreen extends StatefulWidget {
  static const routeName = '/highlights-feed';
  const HighlighsFeedScreen({Key? key}) : super(key: key);

  @override
  State<HighlighsFeedScreen> createState() => _HighlighsFeedScreenState();
}

class _HighlighsFeedScreenState extends State<HighlighsFeedScreen> {
  late Future _highlightsFuture;

  Future fetchHighlights() {
    return Provider.of<Highlights>(context, listen: false)
        .fetchAndSetHighlights();
  }

  @override
  void initState() {
    super.initState();
    _highlightsFuture = fetchHighlights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highlights Feed'),
      ),
      body: FutureBuilder(
          future: _highlightsFuture,
          builder: (ctx, highlightsData) {
            if (highlightsData.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (highlightsData.hasError) {
              return Center(
                child: Text('An error occurred ${highlightsData.error}'),
              );
            }

            return Consumer<Highlights>(
              builder: (ctx, data, _) => ListView.builder(
                itemCount: data.highlights.length,
                itemBuilder: (ctx, idx) => Highlight(
                  data.highlights[idx].id,
                  data.highlights[idx].title,
                  data.highlights[idx].data,
                ),
              ),
            );
          }),
    );
  }
}
