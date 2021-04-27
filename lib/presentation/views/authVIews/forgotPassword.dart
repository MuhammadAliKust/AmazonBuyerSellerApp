import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViews extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VerticalSpace(100),
        Center(child: Image.asset('assets/images/forgotPwd.png')),
        VerticalSpace(40),
        AppHeadings("Forgot Password"),
        VerticalSpace(60),
        TextFieldLabel("Email"),
        VerticalSpace(10),
        AuthTextField(
          label: "Enter your Email",
          controller: _emailController,
          validator: (val) {},
        ),
        VerticalSpace(25),
        AppButton(text: "Send Password Reset Link", onPressed: () {})
      ],
    );
  }
}
