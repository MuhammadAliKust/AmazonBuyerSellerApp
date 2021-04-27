import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  final String text;
  final bool isRequireLessPadding;

  TextFieldLabel(
    this.text, {
    this.isRequireLessPadding = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isRequireLessPadding ? 18 : 30.0),
          child: Text(text,
              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black))),
        ),
      ],
    );
  }
}
