import 'package:flutter/material.dart';

import 'dynamicFontSize.dart';
import 'heigh_sized_box.dart';

class NoData extends StatelessWidget {
  const NoData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            color: Colors.grey[400],
            size: 65,
          ),
          VerticalSpace(10),
          Center(
            child: DynamicFontSize(
              label: "No Data Available!",
              color: Colors.grey[400],
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
