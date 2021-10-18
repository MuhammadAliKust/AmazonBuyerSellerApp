import 'dart:io';

import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/add_money_model.dart';
import 'package:amazon_sale_app/infrastructure/services/add_money_services.dart';
import 'package:amazon_sale_app/infrastructure/services/uploadFileServices.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/dynamicFontSize.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class AddMoneyView extends StatefulWidget {
  @override
  _AddMoneyViewState createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<AddMoneyView> {
  TextEditingController _emailController = TextEditingController();

  AddMoneyServices _addMoneyServices = AddMoneyServices();

  bool isLoading = false;

  UploadFileServices _uploadFileServices = UploadFileServices();

  File _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Add Money"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      child: Column(
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
                _getCopyField(context, text: user.getUserDetails.paypal),
                VerticalSpace(17),
                TextFieldLabel(
                  "Payoneer Account",
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                _getCopyField(context, text: user.getUserDetails.payoneer),
                VerticalSpace(17),
                TextFieldLabel(
                  "Payment Proof",
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                _getImagePicker(context),
                VerticalSpace(37),
                AppButton(
                    text: "Submit",
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      _uploadFileServices
                          .getUrl(context, file: _file)
                          .then((value) {
                        _addMoneyServices
                            .addMoney(context,
                                model: AddMoney(
                                    uid: user.getUserDetails.uid,
                                    image: value,
                                    payoneerAccount:
                                        user.getUserDetails.payoneer,
                                    paypalAccount: user.getUserDetails.paypal))
                            .then((value) async {
                          isLoading = false;
                          setState(() {});
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (ctxtDialog) {
                                return CupertinoAlertDialog(
                                  title: Text(
                                    "message",
                                    style: TextStyle(color: Colors.green[900]),
                                  ),
                                  content: Text(
                                    "Our team will send your payment within 24 hours.",
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(ctxtDialog);
                                          pushNewScreen(context,
                                              screen: MyProducts());
                                        },
                                        child: Text("Okay"))
                                  ],
                                );
                              });
                        });
                      });
                    })
              ],
            ),
          ))
        ],
      ),
    );
  }

  _getCopyField(BuildContext context, {String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: FrontEndConfigs.appBaseColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Flexible(
                  child: DynamicFontSize(
                    label: text,
                    fontSize: 16,
                    isAlignCenter: false,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.copy,
                  color: FrontEndConfigs.appBaseColor,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImagePicker _imagePicker = ImagePicker();

  Future getFile() async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _getImagePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: FrontEndConfigs.appBaseColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Flexible(
                  child: DynamicFontSize(
                    label: _file == null
                        ? "Attach Refund Screenshot"
                        : _file.path.split('/').last,
                    fontSize: 16,
                    isAlignCenter: false,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () => getFile(),
                child: Icon(
                  Icons.attach_file,
                  color: FrontEndConfigs.appBaseColor,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
