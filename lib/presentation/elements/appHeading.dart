import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/material.dart';

class AppHeadings extends StatelessWidget {
  final String text;
  AppHeadings(this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(text,
              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: FrontEndConfigs.appBaseColor))),
        ),
      ],
    );
  }
}
