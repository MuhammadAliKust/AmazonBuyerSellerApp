import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/material.dart';

class HeaderEarningRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      color: Color(0xffF5F5F5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPaymentWidget(title: "Pending"),
              _buildVerticalDivider(),
              _buildPaymentWidget(title: "Earned"),
              _buildVerticalDivider(),
              _buildPaymentWidget(title: "Ordered"),
            ],
          ),
        ],
      ),
    );
  }

  _buildPaymentWidget({String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "\$50.00",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: FrontEndConfigs.appBaseColor),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }

  _buildVerticalDivider() {
    return Container(
      child: VerticalDivider(),
      height: 45,
      width: 1,
    );
  }
}
