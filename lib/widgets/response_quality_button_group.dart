import 'package:flutter/material.dart';

class ResponseQualityButtonGroup extends StatefulWidget {
  final void Function(int) responseQualityListener;

  ResponseQualityButtonGroup(this.responseQualityListener);

  @override
  State<ResponseQualityButtonGroup> createState() =>
      _ResponseQualityButtonGroupState();
}

class _ResponseQualityButtonGroupState
    extends State<ResponseQualityButtonGroup> {
  int value = 0;

  Widget radioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
        widget.responseQualityListener(index);
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        radioButton("0", 0),
        radioButton("1", 1),
        radioButton("2", 2),
        radioButton("3", 3),
        radioButton("4", 4),
        radioButton("5", 5),
      ],
    );
  }
}
