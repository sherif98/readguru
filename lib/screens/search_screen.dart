import 'package:flutter/material.dart';
import 'package:readguru/screens/list_titles_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Search for a highlight'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(
            'BROWSE YOUR CONTENT',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(ListTitlesScreen.routeName);
          },
          title: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Books',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          title: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Tags',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
