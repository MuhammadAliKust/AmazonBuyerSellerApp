import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/customNotificationTile.dart';
import 'package:amazon_sale_app/presentation/elements/noData.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final bool fromNavbar;
  MessagesScreen({this.fromNavbar = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(context, title: "Messages", doestNotshow: fromNavbar),
      drawer: !fromNavbar ? AppDrawer() : null,
      body: NoData(),
      // body: _getUI(context),
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
