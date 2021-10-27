import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/views/appViews/addMoney.dart';
import 'package:amazon_sale_app/presentation/views/appViews/howToUse.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:amazon_sale_app/presentation/views/appViews/productCheckedScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/refunded_product_list_view.dart';
import 'package:amazon_sale_app/presentation/views/appViews/reviewd_product_list_view.dart';
import 'package:amazon_sale_app/presentation/views/appViews/withdrawMoney.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/login.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'heigh_sized_box.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          VerticalSpace(20),
          Divider(),
          _getExpansionTile(context),
          Divider(),
          _createDrawerItem(
              icon: Icons.attach_money,
              text: 'Add Money',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMoneyView()));
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.attach_money,
              text: 'Withdraw Money',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WithdrawMoneyView()));
              }),
          Divider(),
          _createDrawerItem(
              iconString: "assets/icons/post.png",
              text: 'Posted Products',
              onTap: () {
                pushNewScreen(context, screen: MyProducts());
              }),
          if (user.getUserDetails.isSeller)
            Column(
              children: [
                Divider(),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(user.getUserDetails.amazon),
                      )
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      FlutterClipboard.copy('https://www.amazon......')
                          .then((value) {
                        Toast.show("Copied", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.copy,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                pushNewScreen(context, screen: LoginView(), withNavBar: false);
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
            child: Text("Order Products"),
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
                        builder: (context) => OrderedProductListView()));
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
                        builder: (context) => ReviewedProductListView()));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _createDrawerItem(
              iconString: "assets/icons/refund.png",
              text: "Refunded Product",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RefundedProductListView()));
              }),
        ),
      ],
      initiallyExpanded: false,
    );
  }

  Widget _createHeader(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    print(user.getUserDetails.toJson('uid'));
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
              user.getUserDetails.userName ?? "n/a",
            ),
            VerticalSpace(5),
            _getHeaderText(
              user.getUserDetails.email ?? "n/a",
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
