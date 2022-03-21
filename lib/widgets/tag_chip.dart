import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String tagId;
  final void Function(String tagId)? onTagDeleted;

  TagChip(this.tagId, {this.onTagDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.black,
        onDeleted: onTagDeleted != null
            ? () {
                onTagDeleted!(tagId);
              }
            : null,
        label: Text(tagId),
      ),
    );
  }
}
