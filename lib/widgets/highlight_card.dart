import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/widgets/detailed_highlight_card.dart';
import 'package:readguru/widgets/highlight_card_tile.dart';

class HighlightCard extends StatelessWidget {
  // final int id;
  // final String title;
  // final String data;

  // HighlightCard(this.id, this.title, this.data);

  @override
  Widget build(BuildContext context) {
    final highlight = Provider.of<Highlight>(context, listen: false);
    print(highlight.id);
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: '',
            pageBuilder: (ctx, _, __) {
              return Center(
                child: Container(
                  height: MediaQuery.of(ctx).size.height / 2,
                  width: MediaQuery.of(ctx).size.width,
                  child: ChangeNotifierProvider.value(
                    value: highlight,
                    child: DetailedHighlightCard(),
                  ),
                ),
              );
            });
      },
      child: Dismissible(
        key: ValueKey(highlight.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'Do you want to completely remove this highlight?'),
              actions: [
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    }),
                TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    }),
              ],
            ),
          );
        },
        onDismissed: (direction) async {
          await Provider.of<Highlights>(context, listen: false)
              .deleteHighlight(highlight.id);
        },
        background: Container(
          color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              HighlightCardTile(
                highlight.titleName,
                highlight.author,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  highlight.data,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
