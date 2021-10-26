import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/withdraw_model.dart';
import 'package:amazon_sale_app/infrastructure/services/withdraw_services.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/flushBar.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WithdrawMoneyView extends StatefulWidget {
  @override
  _WithdrawMoneyViewState createState() => _WithdrawMoneyViewState();
}

class _WithdrawMoneyViewState extends State<WithdrawMoneyView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  int index = -1;

  final _formKey = GlobalKey<FormState>();

  WithdrawMoneyServices _withdrawMoneyServices = WithdrawMoneyServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Withdraw Money"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          HeaderEarningRow(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                VerticalSpace(40),
                TextFieldLabel(
                  "Enter Withdrawal Amount",
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                AuthTextField(
                  label: "Amount",
                  controller: _amountController,
                  isNumberField: true,
                  validator: (val) =>
                      val.isEmpty ? "Field cannot be empty." : null,
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
                  validator: (val) =>
                      val.isEmpty ? "Field cannot be empty." : null,
                  icon: Icons.attach_email,
                  isRequireLessPadding: true,
                ),
                VerticalSpace(37),
                AppButton(
                    text: "Submit",
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      if (index == -1) {
                        getFlushBar(context,
                            title: "Kindly select account type.",
                            icon: Icons.info_outline,
                            color: Colors.blue);
                        return;
                      }
                      if (int.parse(_amountController.text) > 0) {
                        getFlushBar(context,
                            title:
                                "Kindly make your balance \$10 to do withdrawl.",
                            icon: Icons.info_outline,
                            color: Colors.blue[800]);
                      } else {
                        _withdrawMoneyServices.withDrawMoney(context,
                            model: WithdrawMoney(
                                uid: user.getUserDetails.uid,
                                withdrawAmount: _amountController.text,
                                accountName:
                                    getIndex == 0 ? "Payoneer" : "PayPal",
                                email: _emailController.text));
                      }
                    })
              ],
            ),
          ))
        ],
      ),
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
                  InkWell(
                    onTap: () {
                      setIndex(i);
                    },
                    child: Icon(
                      i == getIndex
                          ? Icons.radio_button_checked_outlined
                          : Icons.radio_button_off,
                      color: FrontEndConfigs.appBaseColor,
                    ),
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

  setIndex(int i) {
    index = i;
    setState(() {});
  }

  get getIndex => index;
}
