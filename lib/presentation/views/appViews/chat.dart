import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/customNotificationTile.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Messages"),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) {
          return CustomNotificationTile(
            image: "assets/images/user.png",
            title: "Muhammad Arif",
            description: "Hi, how are you?",
            time: "02:30 PM",
            isChat: true,
            counter: 2,
          );
        });
  }
}
