import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:flutter/material.dart';

class DashBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Home"),
      drawer: AppDrawer(),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(100),
        Image.asset('assets/images/noPost.png'),
        VerticalSpace(30),
        Text(
          "It seems you didn't created a post\nclick on the create post button to\ncreate your first post.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        VerticalSpace(60),
        AppButton(
            text: "Create Post",
            onPressed: () {
              NavigationHelper.pushNamed(context, Routes.CREATE_POST_ROUTE, "");
            })
      ],
    );
  }
}
