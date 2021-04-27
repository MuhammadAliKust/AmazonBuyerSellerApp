import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/elements/toggleView.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VerticalSpace(70),
          Center(
              child: Image.asset(
            'assets/images/login.png',
            height: 170,
          )),
          VerticalSpace(40),
          AppHeadings("Login Here..."),
          VerticalSpace(50),
          TextFieldLabel("Email"),
          VerticalSpace(10),
          AuthTextField(
            label: "Email ID",
            controller: _emailController,
            validator: (val) {},
            icon: Icons.person,
          ),
          VerticalSpace(17),
          TextFieldLabel("Password"),
          VerticalSpace(10),
          AuthTextField(
            label: "Password",
            controller: _emailController,
            validator: (val) {},
            icon: Icons.vpn_key,
          ),
          VerticalSpace(20),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Forgot Password?",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          VerticalSpace(25),
          AppButton(text: "Login", onPressed: () {}),
          ToggleView(true)
        ],
      ),
    );
  }
}
