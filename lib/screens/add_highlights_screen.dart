import 'package:flutter/material.dart';
import 'package:readguru/screens/add_text_highlight_screen.dart';

class AddHighlightsScreen extends StatelessWidget {
  const AddHighlightsScreen({Key? key}) : super(key: key);

  Widget _buildSyncTile(
      String imageUrl, IconData icon, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          child: FittedBox(
            child: Image.network(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: TextButton.icon(
          label: Text('Sync'),
          icon: Icon(icon),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            color: Colors.blue.withOpacity(0.2),
            height: 250,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    label: Text(
                      'Add via text',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddTextHighlightScreen.routeName);
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                    label: Text(
                      'Add via photo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 50,
          // ),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'Connect & Sync',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSyncTile(
            'https://m.media-amazon.com/images/I/71ZCJYuOqIL._SX425_.png',
            Icons.sync_sharp,
            'Kindle',
            'Sync your latest highlights from your Kindle books',
          ),
          _buildSyncTile(
            'https://miro.medium.com/max/2000/1*jfdwtvU6V6g99q3G7gq7dQ.png',
            Icons.sync_sharp,
            'Medium',
            'Sync your article highlights from Medium',
          ),
          _buildSyncTile(
            'https://www.seekpng.com/png/detail/5-54303_twitter-introduces-a-new-app-for-windows-twitter.png',
            Icons.sync_sharp,
            'Twitter',
            'Sync favorite tweets and threads from Twitter',
          ),
          _buildSyncTile(
            'https://as1.ftcdn.net/v2/jpg/03/21/76/60/1000_F_321766089_3RWE6px71eNSpOisUu1HQsmNspSqVIkO.jpg',
            Icons.sync_sharp,
            'Email',
            'Import highlights by sending an email to Readguru',
          ),
        ],
      ),
    );
  }
}
