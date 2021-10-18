import 'package:flutter/material.dart';

class ProductNameTextStyle extends StatelessWidget {
  final String producName;
  ProductNameTextStyle(this.producName);
  @override
  Widget build(BuildContext context) {
    return Text(
      producName,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
