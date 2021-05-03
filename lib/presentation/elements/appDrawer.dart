import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/views/appViews/addMoney.dart';
import 'package:amazon_sale_app/presentation/views/appViews/howToUse.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:amazon_sale_app/presentation/views/appViews/productTimerScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/profileView.dart';
import 'package:amazon_sale_app/presentation/views/appViews/refundedProduct.dart';
import 'package:amazon_sale_app/presentation/views/appViews/submittedSSfromBuyer.dart';
import 'package:amazon_sale_app/presentation/views/appViews/withdrawMoney.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'heigh_sized_box.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            VerticalSpace(20),
            Divider(),
            _getExpansionTile(context),
            Divider(),
            _createDrawerItem(
                icon: Icons.attach_money,
                text: 'Add Money',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddMoney()));
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.attach_money,
                text: 'Withdraw Money',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WithdrawMoney()));
                }),
            Divider(),
            _createDrawerItem(
                iconString: "assets/icons/post.png",
                text: 'Posted Products',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProducts(true)));
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.person_outline,
                text: 'Profile',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HowToUse()));
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.exit_to_app_outlined,
                text: 'Sign Out',
                onTap: () async {
                  pushNewScreen(context,
                      screen: LoginView(), withNavBar: false);
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductTimerView()));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/review.png",
              text: "Submitted Review",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubmittedScreenShotFromBuyer()));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/refund.png",
              text: "Refunded Product",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RefundedProduct()));
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
