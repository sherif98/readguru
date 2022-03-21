import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/tags.dart';

class TagHighlightDialog extends StatefulWidget {
  const TagHighlightDialog({Key? key}) : super(key: key);

  @override
  State<TagHighlightDialog> createState() => _TagHighlightDialogState();
}

class _TagHighlightDialogState extends State<TagHighlightDialog> {
  TextEditingController? _tagController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Tags>(context, listen: false).fetchTags(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer<Tags>(
          builder: (ctx, data, _) => AlertDialog(
            title: const Text('Create a new tag or use an existing one'),
            content: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return data.stringTags.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                _tagController = fieldTextEditingController;
                return TextField(
                  controller: fieldTextEditingController,
                  autofocus: true,
                  focusNode: fieldFocusNode,
                );
              },
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(_tagController!.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
