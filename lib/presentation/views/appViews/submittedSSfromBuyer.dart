import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/boldCaption.dart';
import 'package:amazon_sale_app/presentation/elements/getProductImage.dart';
import 'package:amazon_sale_app/presentation/elements/getReviewSS.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/lightCaption.dart';
import 'package:amazon_sale_app/presentation/elements/productNameTextStyle.dart';
import 'package:flutter/material.dart';

class SubmittedScreenShotFromBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Product"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                GetProductImage(
                  showChat: true,
                ),
                VerticalSpace(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductNameTextStyle('Asad'),
                      LightCaption("04/04/21")
                    ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetReviewSS('Asad'),
                        HorizontalSpace(10),
                        GetReviewSS('Asad'),
                      ],
                    ),
                  ),
                ),
                VerticalSpace(20),
                // AppButton(text: "Submit", onPressed: () {})
              ],
            ),
          ),
        ),
      ],
    );
  }
}
