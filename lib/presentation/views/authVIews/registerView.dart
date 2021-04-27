import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/appHeading.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/elements/toggleView.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _emailController = TextEditingController();

  String countryCode;
  String countryName;

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
          Center(child: Image.asset('assets/images/login.png')),
          VerticalSpace(40),
          AppHeadings("Register Here"),
          VerticalSpace(50),
          TextFieldLabel("User Name"),
          VerticalSpace(10),
          AuthTextField(
            label: "John Doe",
            controller: _emailController,
            validator: (val) {},
            icon: Icons.person,
          ),
          VerticalSpace(17),
          TextFieldLabel("Email"),
          VerticalSpace(10),
          AuthTextField(
            label: "xyz@mail.com",
            controller: _emailController,
            validator: (val) {},
            icon: Icons.email,
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
          VerticalSpace(17),
          TextFieldLabel("Select Country"),
          VerticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
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
                        countryName == null ? 'Select Country' : countryName,
                        style: TextStyle(
                            color: FrontEndConfigs.appBaseColor, fontSize: 16),
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
            controller: _emailController,
            validator: (val) {},
          ),
          VerticalSpace(17),
          TextFieldLabel("Amazon"),
          VerticalSpace(10),
          AuthTextField(
            label: "Paste your Amazon Account Link..",
            controller: _emailController,
            validator: (val) {},
          ),
          VerticalSpace(17),
          _getRadioButtonRow(),
          VerticalSpace(24),
          AppButton(text: "Register", onPressed: () {}),
          ToggleView(false)
        ],
      ),
    );
  }

  _getRadioButtonRow() {
    return Container(
      height: 30,
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.radio_button_off,
                    color: FrontEndConfigs.appBaseColor,
                  ),
                  HorizontalSpace(6),
                  Text(
                    "Buyer",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: FrontEndConfigs.appBaseColor),
                  ),
                  HorizontalSpace(17),
                ],
              );
            }),
      ),
    );
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
                    cursorColor: FrontEndConfigs.appBaseColor,
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
}
