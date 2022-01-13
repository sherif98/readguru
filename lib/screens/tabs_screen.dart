import 'package:flutter/material.dart';
import 'package:readguru/screens/add_highlights_screen.dart';
import 'package:readguru/screens/home_screen.dart';
import 'package:readguru/screens/profile_screen.dart';
import 'package:readguru/screens/search_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': HomeScreen(), 'title': 'Readguru'},
      {'page': AddHighlightsScreen(), 'title': 'Add Highlights'},
      {'page': SearchScreen(), 'title': 'Search'},
      {'page': ProfileScreen(), 'title': 'Profile'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Highlights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
