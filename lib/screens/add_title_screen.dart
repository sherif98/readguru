import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/titles.dart' as titles;

class AddTitleScreen extends StatefulWidget {
  static const routeName = '/add-title';
  const AddTitleScreen({Key? key}) : super(key: key);

  @override
  State<AddTitleScreen> createState() => _AddTitleScreenState();
}

class _AddTitleScreenState extends State<AddTitleScreen> {
  final _form = GlobalKey<FormState>();
  var _title = titles.Title(id: 0, author: '', titleName: '');

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    await Provider.of<titles.Titles>(context, listen: false).addTitle(_title);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Title'),
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
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter title name here'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                        _title = titles.Title(
                          id: _title.id,
                          titleName: value!,
                          author: _title.author,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter author name here'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = titles.Title(
                          id: _title.id,
                          titleName: _title.titleName,
                          author: value!,
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
                onPressed: _saveForm,
                child: Text('Save Title'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
