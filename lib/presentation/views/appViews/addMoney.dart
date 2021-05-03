import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:flutter/material.dart';

class AddMoney extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Add Money"),
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
          child: Column(
            children: [
              VerticalSpace(40),
              TextFieldLabel(
                "Paypal Account",
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              AuthTextField(
                label: "Paypal Email",
                controller: _emailController,
                validator: (val) {},
                icon: Icons.copy,
                isRequireLessPadding: true,
              ),
              VerticalSpace(17),
              TextFieldLabel(
                "Payoneer Account",
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              AuthTextField(
                label: "Payoneer Email",
                controller: _emailController,
                validator: (val) {},
                icon: Icons.copy,
                isRequireLessPadding: true,
              ),
              VerticalSpace(17),
              TextFieldLabel(
                "Payment Proof",
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              AuthTextField(
                label: "Attach Screenshot",
                controller: _emailController,
                validator: (val) {},
                icon: Icons.attach_file,
                isRequireLessPadding: true,
              ),
              VerticalSpace(37),
              AppButton(
                  text: "Submit",
                  onPressed: () {
                    NavigationHelper.pushReplacementName(
                        context, Routes.MY_PRODUCTS_ROUTE, "");
                  })
            ],
          ),
        ))
      ],
    );
  }
}
