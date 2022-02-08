import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readguru/providers/highlight.dart';
import 'package:readguru/providers/highlights.dart';
import 'package:readguru/widgets/highlight_card.dart';
import 'package:readguru/widgets/response_quality_button_group.dart';

class HighlightUnderReviewState {
  int responseQuality = -1;
}

class DailyHighlightsReviewScreen extends StatefulWidget {
  static const routeName = '/daily-highlights-review';
  const DailyHighlightsReviewScreen({Key? key}) : super(key: key);

  @override
  _DailyHighlightsReviewScreenState createState() =>
      _DailyHighlightsReviewScreenState();
}

class _DailyHighlightsReviewScreenState
    extends State<DailyHighlightsReviewScreen> {
  int _index = 0;
  late final List<Highlight> _loadedHighlights;
  bool _isLoading = false;

  void _responseQualityListener(int chosenResponseQuality) {
    print(chosenResponseQuality);
  }

  void _loadDailyReviewHighlights() async {
    _loadedHighlights = await Provider.of<Highlights>(context, listen: false)
        .fetchDailyReviewHighlights()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _loadDailyReviewHighlights();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Review'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: LimitedBox(
                    maxHeight: 10,
                    maxWidth: width,
                    child: HighlightCard(
                      _loadedHighlights[_index].id,
                      _loadedHighlights[_index].titleName,
                      _loadedHighlights[_index].data,
                    ),
                  ),
                  // return ListView.builder(
                  //   physics: PageScrollPhysics(),
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: highlights.length,
                  //   itemBuilder: (ctx, idx) => LimitedBox(
                  //     maxHeight: 10,
                  //     maxWidth: width,
                  //     child: HighlightCard(
                  //       highlights[idx].id,
                  //       highlights[idx].title,
                  //       highlights[idx].data,
                  //     ),
                  //   ),
                  // );
                ),
                ResponseQualityButtonGroup(_responseQualityListener),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.remove,
                        size: 20,
                      ),
                      label: Text(
                        'Discard',
                      ),
                      onPressed: () {},
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.done,
                        size: 20,
                      ),
                      label: Text(
                        'Done',
                      ),
                      onPressed: () {
                        setState(() {
                          _index++;
                        });
                        // _itemScrollController.scrollTo(index: index, duration: duration)
                      },
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
