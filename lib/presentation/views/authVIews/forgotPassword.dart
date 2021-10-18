import 'package:amazon_sale_app/application/errorStrings.dart';
import 'package:amazon_sale_app/configurations/enums.dart';
import 'package:amazon_sale_app/infrastructure/services/authServices.dart';
import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/dialog.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/navigation_dialog.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/login.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ForgotPasswordViews extends StatefulWidget {
  @override
  _ForgotPasswordViewsState createState() => _ForgotPasswordViewsState();
}

class _ForgotPasswordViewsState extends State<ForgotPasswordViews> {
  TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    var auth = Provider.of<AuthServices>(context);
    return LoadingOverlay(
      isLoading: auth.status == Status.Authenticating,
      child: Column(
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
          AppButton(
              text: "Send Password Reset Link",
              onPressed: () {
                isLoading = true;
                setState(() {});
                _forgotPassword(context);
              })
        ],
      ),
    );
  }

  _forgotPassword(BuildContext context) {
    AuthServices _services = Provider.of<AuthServices>(context, listen: false);
    _services
        .forgotPassword(context, email: _emailController.text)
        .then((val) async {
      if (_services.status == Status.Authenticated) {
        showNavigationDialog(context,
            message:
                "An email with password reset link has been sent to your email inbox",
            buttonText: "Okay", navigation: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }, secondButtonText: "", showSecondButton: false);
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
