import 'package:flutter/material.dart';

import 'heigh_sized_box.dart';

class ProfileTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final String iconString;
  ProfileTile(
      {@required this.label, @required this.value, this.icon, this.iconString});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: _getProfileText(label),
        ),
        VerticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null
                    ? ImageIcon(AssetImage(iconString))
                    : Icon(
                        icon,
                        color: Color(0xff707070),
                      ),
              ],
            ),
            title: _getProfileText(value),
          ),
        ),
        VerticalSpace(7),
        Divider()
      ],
    );
  }

  _getProfileText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, color: Color(0xff707070), fontWeight: FontWeight.bold),
    );
  }
}
