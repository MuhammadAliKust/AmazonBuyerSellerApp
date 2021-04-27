import 'package:flutter/material.dart';

class BoldCaption extends StatelessWidget {
  final String text;

  BoldCaption(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .caption
          .merge(TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
