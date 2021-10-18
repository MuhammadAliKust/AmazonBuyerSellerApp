import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/boldCaption.dart';
import 'package:amazon_sale_app/presentation/elements/getProductImage.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/lightCaption.dart';
import 'package:amazon_sale_app/presentation/elements/productNameTextStyle.dart';
import 'package:flutter/material.dart';

class OrderedProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, title: "Product"),
        body: _getUI(context),
        drawer: AppDrawer());
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        GetProductImage(),
        VerticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ProductNameTextStyle('Asad'), LightCaption("04/04/21")],
          ),
        ),
        VerticalSpace(7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldCaption("by Alhamrah"),
              LightCaption("ID: #1234556")
            ],
          ),
        ),
        VerticalSpace(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Black head phones with soft ear foam. Specially designed for comfort with very high quality of sound results. High bass and clear sound.",
            style: TextStyle(fontSize: 14),
          ),
        ),
        VerticalSpace(40),
        AppButton(
            text: "Submit Review",
            onPressed: () {
              NavigationHelper.pushReplacementName(
                  context, Routes.SUBMIT_REVIEW_ROUTE, "");
            }),
        VerticalSpace(15),
        AppButton(
            text: "Submit",
            onPressed: () {
              NavigationHelper.pushReplacementName(
                  context, Routes.MY_PRODUCTS_ROUTE, "");
            }),
      ],
    );
  }
}
