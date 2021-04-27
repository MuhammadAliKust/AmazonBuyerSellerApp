import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/boldCaption.dart';
import 'package:amazon_sale_app/presentation/elements/getProductImage.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/lightCaption.dart';
import 'package:amazon_sale_app/presentation/elements/productNameTextStyle.dart';
import 'package:flutter/material.dart';

class BuyerProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Product"),
      body: _getUI(context),
    );
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
            children: [ProductNameTextStyle(), LightCaption("04/04/21")],
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
        _getAttachContainer(text: "Attach Order Screenshot"),
        VerticalSpace(10),
        _getAttachContainer(text: "Attach Review Screenshot"),
        VerticalSpace(20),
        AppButton(text: "Submit", onPressed: () {})
      ],
    );
  }

  _getAttachContainer({String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: FrontEndConfigs.appBaseColor,
            )),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                text,
                style: TextStyle(
                    color: FrontEndConfigs.appBaseColor, fontSize: 16),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_file,
                  color: FrontEndConfigs.appBaseColor,
                  size: 20,
                ),
                HorizontalSpace(15)
              ],
            )
          ],
        ),
      ),
    );
  }
}
