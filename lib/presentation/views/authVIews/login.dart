import 'package:amazon_sale_app/application/errorStrings.dart';
import 'package:amazon_sale_app/application/loginBusinessLogic.dart';
import 'package:amazon_sale_app/configurations/enums.dart';
import 'package:amazon_sale_app/infrastructure/services/authServices.dart';
import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/bottomNavBar.dart';
import 'package:amazon_sale_app/presentation/elements/dialog.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/elements/toggleView.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  LoginBusinessLogic data = LoginBusinessLogic();

  final _formKey = GlobalKey<FormState>();
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
      progressIndicator: CircularProgressIndicator(),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                icon: Icons.person,
              ),
              VerticalSpace(17),
              TextFieldLabel("Password"),
              VerticalSpace(10),
              AuthTextField(
                label: "Password",
                controller: _pwdController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                icon: Icons.vpn_key,
              ),
              VerticalSpace(20),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordViews()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                alignment: Alignment.centerRight,
              ),
              VerticalSpace(25),
              AppButton(
                  text: "Login",
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    loginUser(
                        context: context,
                        data: data,
                        email: _emailController.text,
                        auth: auth,
                        password: _pwdController.text);
                  }),
              ToggleView(true)
            ],
          ),
        ),
      ),
    );
  }

  loginUser(
      {@required BuildContext context,
      @required LoginBusinessLogic data,
      @required String email,
      @required AuthServices auth,
      @required String password}) {
    data
        .loginUserLogic(
      context,
      email: email,
      password: password,
    )
        .then((val) async {
      if (auth.status == Status.Authenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
