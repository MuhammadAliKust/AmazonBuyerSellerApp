import 'package:flutter/material.dart';

import 'horizontal_sized_box.dart';

class GetReviewSS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/SS.png',
              ),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 17,
                    ),
                  ),
                ),
                HorizontalSpace(8),
                Container(
                  height: 30,
                  width: 30,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Center(
                    child: Icon(
                      Icons.download_rounded,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
