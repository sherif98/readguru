import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/providers/titles.dart' as titles;
import 'package:readguru/screens/add_title_screen.dart';

class AddTextHighlightScreen extends StatefulWidget {
  static const routeName = '/add-text-highlight';
  const AddTextHighlightScreen({Key? key}) : super(key: key);

  @override
  _AddTextHighlightScreenState createState() => _AddTextHighlightScreenState();
}

class _AddTextHighlightScreenState extends State<AddTextHighlightScreen> {
  final _form = GlobalKey<FormState>();
  var _highlight = Highlight(id: '', data: '', titleId: '', titleName: '');
  late Future _titlesFuture;

  Future fetchTitles() {
    return Provider.of<titles.Titles>(context, listen: false)
        .fetchAndSetTitles();
  }

  @override
  void initState() {
    super.initState();
    _titlesFuture = fetchTitles();
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    await Provider.of<Highlights>(context, listen: false)
        .addHighlight(_highlight);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Text Highlight'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _titlesFuture,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return Consumer<titles.Titles>(
                          builder: (ctx, data, _) =>
                              DropdownButtonFormField<titles.Title>(
                            hint: Text('Choose a title'),
                            items: data.titles.map((e) {
                              return DropdownMenuItem<titles.Title>(
                                child: Text(e.titleName),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null) {
                                return 'Please choose a title';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _highlight = Highlight(
                                id: _highlight.id,
                                titleId: value!.id,
                                titleName: value.titleName,
                                data: _highlight.data,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    OutlinedButton(
                      child: Text(
                        'Create new title',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddTitleScreen.routeName);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Type/Paste your highlight here'),
                      textInputAction: TextInputAction.done,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _highlight = Highlight(
                          id: _highlight.id,
                          titleId: _highlight.titleId,
                          titleName: _highlight.titleName,
                          data: value!,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _saveForm, child: Text('Save Highlight')),
            ),
          ],
        ),
      ),
    );
  }
}
