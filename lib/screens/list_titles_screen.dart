import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/titles.dart';
import 'package:readguru/screens/title_highlights_screen.dart';

class ListTitlesScreen extends StatefulWidget {
  static const routeName = '/list-titles';
  const ListTitlesScreen({Key? key}) : super(key: key);

  @override
  _ListTitlesScreenState createState() => _ListTitlesScreenState();
}

class _ListTitlesScreenState extends State<ListTitlesScreen> {
  late Future _titlesFuture;

  Future fetchTitles() {
    return Provider.of<Titles>(context, listen: false).fetchAndSetTitles();
  }

  @override
  void initState() {
    super.initState();
    _titlesFuture = fetchTitles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Titles'),
      ),
      body: FutureBuilder(
        future: _titlesFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Consumer<Titles>(
            builder: (ctx, data, _) => ListView.builder(
              itemCount: data.titles.length,
              itemBuilder: (_, idx) => ListTile(
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
                title: Text(data.titles[idx].titleName),
                subtitle: Text(data.titles[idx].author),
                trailing: Text('5'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                      TitleHighlightsScreen.routeName,
                      arguments: data.titles[idx].titleName);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
