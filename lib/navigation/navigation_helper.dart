import 'package:flutter/material.dart';

class NavigationHelper {
  static pushReplacementName(BuildContext context, String routeName, var args) {
    Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static pushNamed(BuildContext context, String routeName, var args) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }
}
