import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readguru/screens/daily_highlights_review_screen.dart';
import 'package:readguru/screens/highlights_feed_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DailyReviewCard(),
        FeedCard(FeedCardType.Highlights),
        FeedCard(FeedCardType.Mastery),
      ],
    );
  }
}

enum FeedCardType {
  Highlights,
  Mastery,
}

class FeedCard extends StatelessWidget {
  final FeedCardType _feedCardType;

  FeedCard(this._feedCardType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _feedCardType == FeedCardType.Mastery
          ? null
          : () {
              Navigator.of(context).pushNamed(HighlighsFeedScreen.routeName);
            },
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 5,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(
            _feedCardType == FeedCardType.Highlights
                ? 'Highlights Feed'
                : 'Mastery Feed',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
            // softWrap: true,
          ),
        ),
      ),
    );
  }
}

class DailyReviewCard extends StatelessWidget {
  const DailyReviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(DailyHighlightsReviewScreen.routeName);
      },
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 5,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd("en_US").format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                // softWrap: true,
              ),
              Divider(
                color: Colors.white,
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Daily Review',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                // softWrap: true,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Review Highlights',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                // softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
