import 'package:flutter/material.dart';

class LightCaption extends StatelessWidget {
  final String text;

  LightCaption(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.caption);
  }
}
