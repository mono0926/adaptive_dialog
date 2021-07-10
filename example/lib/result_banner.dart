import 'package:flutter/material.dart';

class ResultBanner extends StatefulWidget {
  const ResultBanner({Key key}) : super(key: key);
  @override
  ResultBannerState createState() => ResultBannerState();
}

class ResultBannerState extends State<ResultBanner> {
  var _text = '';

  void updateText(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      content: Text('Result: $_text'),
      actions: <Widget>[
        FlatButton(
          child: Text('Clear'),
          onPressed: () => updateText(''),
        )
      ],
    );
  }
}
