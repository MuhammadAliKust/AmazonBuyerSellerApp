import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:flutter/material.dart';

import 'boldCaption.dart';
import 'lightCaption.dart';

class CustomNotificationTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final bool isChat;
  final int counter;

  CustomNotificationTile(
      {@required this.image,
      @required this.title,
      @required this.description,
      @required this.time,
      this.counter,
      this.isChat = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(image),
          ),
          title: BoldCaption(title),
          subtitle: LightCaption(description),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LightCaption(time),
              if (isChat) VerticalSpace(10),
              if (isChat) _getBadge()
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  _getBadge() {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: FrontEndConfigs.appBaseColor),
      child: Center(
        child: Text(
          counter.toString(),
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }
}
