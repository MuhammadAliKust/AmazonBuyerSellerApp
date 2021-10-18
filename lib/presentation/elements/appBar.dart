import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context,
    {@required String title, bool doestNotshow = false}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    leading: !doestNotshow
        ? Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu, size: 28, color: Colors.white),
              );
            },
          )
        : Container(),
    actions: [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            height: 22,
            width: 46,
            child: Center(
                child: Text(
              "\$0",
              style: TextStyle(fontSize: 14),
            )),
          ),
        ),
      )
    ],
  );
}
