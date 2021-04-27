import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:flutter/material.dart';

class WithdrawMoney extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Withdraw Money"),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(40),
        TextFieldLabel(
          "Enter Withdrawal Amount",
          isRequireLessPadding: true,
        ),
        VerticalSpace(10),
        AuthTextField(
          label: "Amount",
          controller: _emailController,
          validator: (val) {},
          icon: Icons.attach_money_outlined,
          isRequireLessPadding: true,
        ),
        VerticalSpace(17),
        TextFieldLabel(
          "Select Account",
          isRequireLessPadding: true,
        ),
        VerticalSpace(10),
        _getRadioButtonRow(context),
        VerticalSpace(17),
        AuthTextField(
          label: "Enter selected Account Email Here",
          controller: _emailController,
          validator: (val) {},
          icon: Icons.attach_file,
          isRequireLessPadding: true,
        ),
        VerticalSpace(37),
        AppButton(text: "Submit", onPressed: () {})
      ],
    );
  }

  _getRadioButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.radio_button_off,
                    color: FrontEndConfigs.appBaseColor,
                  ),
                  HorizontalSpace(6),
                  Container(
                    child: Image.asset(
                      i == 0
                          ? 'assets/images/payoneer.png'
                          : "assets/images/paypal.png",
                    ),
                  ),
                  HorizontalSpace(80)
                ],
              );
            }),
      ),
    );
  }
}
