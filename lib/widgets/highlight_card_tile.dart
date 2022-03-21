import 'package:flutter/material.dart';

enum HighlightAction {
  CopyText,
  AddTag,
}

class HighlightCardTile extends StatelessWidget {
  final String title;
  final String author;

  HighlightCardTile(this.title, this.author);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(author),
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
    );
  }
}
