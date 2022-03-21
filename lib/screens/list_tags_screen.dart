import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/tags.dart';
import 'package:readguru/screens/tag_highlights_screen.dart';
import 'package:readguru/widgets/tag_chip.dart';

class ListTagsScreen extends StatelessWidget {
  static const routeName = '/list-tags';

  const ListTagsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tags'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Favorites >'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Discards >'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Search Tags'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: Provider.of<Tags>(context, listen: false).fetchTags(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Consumer<Tags>(
                builder: (ctx, data, _) => Expanded(
                  child: ListView.builder(
                    itemCount: data.tags.length,
                    itemBuilder: (bCtx, idx) => Dismissible(
                      key: ValueKey(data.tags[idx].id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'Do you want to completely remove this tag?'),
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
                        await Provider.of<Tags>(context, listen: false)
                            .deleteTag(data.tags[idx].id);
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                      ),
                      child: ListTile(
                        leading: TagChip(data.tags[idx].id),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${data.tags[idx].numberOfHighlights}'),
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (selectedAction) {},
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  child: Text('View All'),
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text('Delete'),
                                  value: 2,
                                ),
                                const PopupMenuItem(
                                  child: Text('Rename'),
                                  value: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              TagHighlightsScreen.routeName,
                              arguments: data.tags[idx]);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
