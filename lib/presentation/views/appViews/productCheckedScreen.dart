import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/productTimerCard.dart';
import 'package:flutter/material.dart';

class ProductCheckedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Ordered Products"),
      drawer: AppDrawer(),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(10),
        Expanded(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, i) {
                return ProductTimerCard(isTimer: false);
              }),
        )
      ],
    );
  }
}
