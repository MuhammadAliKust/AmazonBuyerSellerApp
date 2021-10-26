import 'package:amazon_sale_app/application/errorStrings.dart';
import 'package:amazon_sale_app/application/signUpBusinissLogic.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/user_model.dart';
import 'package:amazon_sale_app/infrastructure/services/authServices.dart';
import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/dialog.dart';
import 'package:amazon_sale_app/presentation/elements/flushBar.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/navigation_dialog.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/elements/toggleView.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/login.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _payPalController = TextEditingController();
  TextEditingController _payoneerController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amazonController = TextEditingController();
  bool isSeller = true;

  String countryCode;
  String countryName;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    AuthServices users = Provider.of<AuthServices>(context);
    SignUpBusinessLogic signUp = Provider.of<SignUpBusinessLogic>(context);
    var user = Provider.of<User>(context);
    return LoadingOverlay(
      isLoading: signUp.status == SignUpStatus.Registering,
      progressIndicator: CircularProgressIndicator(),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpace(70),
              Center(child: Image.asset('assets/images/login.png')),
              VerticalSpace(40),
              AppHeadings("Register Here"),
              VerticalSpace(50),
              TextFieldLabel("User Name"),
              VerticalSpace(10),
              AuthTextField(
                label: "John Doe",
                controller: _userNameController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                icon: Icons.person,
              ),
              VerticalSpace(17),
              TextFieldLabel("Email"),
              VerticalSpace(10),
              AuthTextField(
                label: "xyz@mail.com",
                controller: _emailController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                icon: Icons.email,
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
              VerticalSpace(17),
              TextFieldLabel("Select Country"),
              VerticalSpace(10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                child: InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: <String>['KN', 'MF'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        countryCode = country.phoneCode;
                        countryName = country.displayNameNoCountryCode;
                        setState(() {});
                        print('Select country: ${country.displayName}');
                      },
                    );
                  },
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
                            countryName == null
                                ? 'Select Country'
                                : countryName,
                            style: TextStyle(
                                color: FrontEndConfigs.appBaseColor,
                                fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              color: FrontEndConfigs.appBaseColor,
                              size: 20,
                            ),
                            HorizontalSpace(15)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              VerticalSpace(17),
              TextFieldLabel("Phone Number"),
              VerticalSpace(10),
              _getPhoneField(),
              VerticalSpace(17),
              TextFieldLabel("Paypal"),
              VerticalSpace(10),
              AuthTextField(
                label: "Paste your PayPal Account",
                controller: _payPalController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
              ),
              VerticalSpace(17),
              TextFieldLabel("Payooner"),
              VerticalSpace(10),
              AuthTextField(
                label: "Paste your PayPal Account",
                controller: _payoneerController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
              ),
              if (isSeller) VerticalSpace(17),
              if (isSeller) TextFieldLabel("Amazon"),
              if (isSeller) VerticalSpace(10),
              if (isSeller)
                AuthTextField(
                  label: "Paste your Amazon Account Link..",
                  controller: _amazonController,
                  validator: (val) =>
                      val.isEmpty ? "Field cannot be empty" : null,
                ),
              VerticalSpace(17),
              _getRadioButtonRow(),
              VerticalSpace(24),
              AppButton(
                  text: "Register",
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    if (countryName == null) {
                      getFlushBar(context,
                          title: "Kindly select country",
                          icon: Icons.info_outline,
                          color: Colors.blue);
                      return;
                    }

                    _signUpUser(context: context, signUp: signUp, user: user);
                  }),
              ToggleView(false)
            ],
          ),
        ),
      ),
    );
  }

  _getRadioButtonRow() {
    return Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                isSeller = false;
                setState(() {});
              },
              child: Icon(
                isSeller ? Icons.radio_button_off : Icons.radio_button_checked,
                color: FrontEndConfigs.appBaseColor,
              ),
            ),
            HorizontalSpace(6),
            Text(
              "Buyer",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: FrontEndConfigs.appBaseColor),
            ),
            HorizontalSpace(17),
            InkWell(
              onTap: () {
                isSeller = true;
                setState(() {});
              },
              child: Icon(
                !isSeller ? Icons.radio_button_off : Icons.radio_button_checked,
                color: FrontEndConfigs.appBaseColor,
              ),
            ),
            HorizontalSpace(6),
            Text(
              "Seller",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: FrontEndConfigs.appBaseColor),
            ),
          ],
        ));
  }

  _getPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: FrontEndConfigs.appBaseColor,
            )),
        height: 60,
        child: Row(
          children: [
            HorizontalSpace(12),
            countryCode == null
                ? Container()
                : Text(
                    "+" + countryCode,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
            HorizontalSpace(12),
            Expanded(
              child: Container(
                  height: 70,
                  child: TextFormField(
                    controller: _phoneController,
                    cursorColor: FrontEndConfigs.appBaseColor,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val.isEmpty ? "Field cannot be empty" : null,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: FrontEndConfigs.appBaseColor),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      errorBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  )),
            ),
            HorizontalSpace(9),
            Icon(
              Icons.call,
              color: FrontEndConfigs.appBaseColor,
              size: 20,
            ),
            HorizontalSpace(15)
          ],
        ),
      ),
    );
  }

  _signUpUser(
      {BuildContext context,
      @required SignUpBusinessLogic signUp,
      @required User user}) {
    signUp
        .registerNewUser(
            email: _emailController.text,
            password: _pwdController.text,
            userModel: UserModel(
                email: _emailController.text,
                userName: _userNameController.text,
                password: _pwdController.text,
                isSeller: isSeller,
                country: countryName,
                number: "+$countryCode ${_phoneController.text}",
                amazon: _amazonController.text,
                payoneer: _payoneerController.text,
                paypal: _payPalController.text),
            context: context,
            user: user)
        .then((value) {
      if (signUp.status == SignUpStatus.Registered) {
        showNavigationDialog(context,
            message: "Thanks for registration.",
            buttonText: "Go to Login", navigation: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }, secondButtonText: "", showSecondButton: false);
      } else if (signUp.status == SignUpStatus.Failed) {
        print("Called");
        showErrorDialog(context,
            message: Provider.of<ErrorString>(context, listen: false)
                .getErrorString());
      }
    });
  }
}
