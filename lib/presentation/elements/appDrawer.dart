import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'heigh_sized_box.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          VerticalSpace(20),
          _createDrawerItem(
              icon: Icons.category,
              text: 'Dashboard',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.MY_PRODUCTS_ROUTE, "");
              }),
          Divider(),
          _getExpansionTile(context),
          Divider(),
          _createDrawerItem(
              icon: Icons.attach_money,
              text: 'Add Money',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.ADD_MONEY_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.attach_money,
              text: 'Withdraw Money',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.WITHDRAW_MONEY_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              iconString: "assets/icons/post.png",
              text: 'Posted Products',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.MY_PRODUCTS_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.person_outline,
              text: 'Profile',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.PROFILE_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.share,
              text: 'https://www.amazon......',
              onTap: () {}),
          Divider(),
          _createDrawerItem(
              icon: Icons.play_arrow,
              text: 'How to use?',
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.HOW_TO_USE_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.exit_to_app_outlined,
              text: 'Sign Out',
              onTap: () async {
                NavigationHelper.pushReplacementName(
                    context, Routes.LOGIN_ROUTE, "");
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report, text: 'Report an issue', onTap: () {}),
          ListTile(
            title: Text('1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _getExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          ImageIcon(
            AssetImage("assets/icons/trending.png"),
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Ordered Products"),
          )
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/order.png",
              text: "Ordered Product",
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.ORDERED_PRODUCTS_ROUTE, "");
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/review.png",
              text: "Submitted Review",
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.SUBMIT_REVIEW_ROUTE, "");
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/refund.png",
              text: "Refunded Product",
              onTap: () {
                NavigationHelper.pushReplacementName(
                    context, Routes.SUBMIT_SS_ROUTE, "");
              }),
        ),
      ],
      initiallyExpanded: false,
    );
  }

  Widget _createHeader() {
    return Container(
      height: 240,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: FrontEndConfigs.appBaseColor),
        child: Column(
          children: [
            VerticalSpace(10),
            Container(
              height: 115,
              width: 115,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/user.png')),
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white)),
            ),
            VerticalSpace(10),
            _getHeaderText(
              "Muhammad Arif",
            ),
            VerticalSpace(5),
            _getHeaderText(
              "kinmaker.ktk@gmail.com",
            ),
          ],
        ),
      ),
    );
  }

  _getHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget _createDrawerItem(
      {IconData icon,
      String text,
      GestureTapCallback onTap,
      String iconString}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon == null
              ? ImageIcon(
                  AssetImage(iconString),
                  color: Colors.black,
                )
              : Icon(
                  icon,
                  color: Colors.black,
                ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
