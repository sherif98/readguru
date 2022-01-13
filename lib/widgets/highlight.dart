import 'package:flutter/material.dart';

enum HighlightAction {
  CopyText,
  AddTag,
}

class Highlight extends StatelessWidget {
  final String id;
  final String title;
  final String data;

  Highlight(this.id, this.title, this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Sherif Eid'),
            leading: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                'https://st2.depositphotos.com/1069290/5358/v/950/depositphotos_53581759-stock-illustration-book-icon-vector-logo.jpg',
                width: 50,
                fit: BoxFit.cover,
                height: 50,
              ),
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (selectedAction) {},
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Copy highlight text'),
                  value: HighlightAction.CopyText,
                ),
                const PopupMenuItem(
                  child: Text('Add Tag'),
                  value: HighlightAction.AddTag,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              data,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
