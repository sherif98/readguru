import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/widgets/highlight_card_tile.dart';
import 'package:readguru/widgets/tag_chip.dart';
import 'package:readguru/widgets/tag_highlight_dialog.dart';

class DetailedHighlightCard extends StatefulWidget {
  @override
  State<DetailedHighlightCard> createState() => _DetailedHighlightCardState();
}

class _DetailedHighlightCardState extends State<DetailedHighlightCard> {
  // void _responseQualityListener(int chosenResponseQuality) {

  final _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final highlight = Provider.of<Highlight>(context, listen: false);
    print(highlight.isFavorite);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HighlightCardTile(highlight.titleName, highlight.author),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              highlight.data,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.edit_note),
                onPressed: () {},
              ),
              Consumer<Highlight>(
                builder: (ctx, highlight, _) => IconButton(
                  icon: Icon(highlight.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    highlight.toggleFavoriteStatus();
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.label_outline),
                onPressed: () async {
                  String? tagName = await getInputTag();
                  if (tagName != null) {
                    highlight.tagHighlight(tagName);
                  }
                },
              ),
            ],
          ),
          Consumer<Highlight>(
            builder: (ctx, highlight, _) => Wrap(
              spacing: 2.0,
              children: highlight.tags
                  .map((t) => TagChip(
                        t,
                        onTagDeleted: (tagId) {
                          highlight.unTagHighlight(tagId);
                        },
                      ))
                  .toList(),
            ),
          ),
          // Container(
          //   child: ResponseQualityButtonGroup(_responseQualityListener),
          // ),
        ],
      ),
    );
  }

  Future<String?> getInputTag() {
    return showDialog(
      context: context,
      builder: (ctx) => TagHighlightDialog(),
    );
  }
}
