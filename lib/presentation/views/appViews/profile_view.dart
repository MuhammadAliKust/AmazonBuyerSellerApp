import 'dart:io';

import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/user_model.dart';
import 'package:amazon_sale_app/infrastructure/services/uploadFileServices.dart';
import 'package:amazon_sale_app/infrastructure/services/user_services.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/bottomNavBar.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/navigation_dialog.dart';
import 'package:amazon_sale_app/presentation/elements/profileImagePicker.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class EditProfileView extends StatefulWidget {
  final UserModel userModel;

  EditProfileView(this.userModel);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController _userNameController = TextEditingController();

  TextEditingController _amazonController = TextEditingController();

  TextEditingController _paypalController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _payoneerController = TextEditingController();

  File _file;

  String countryCode;
  String countryName;

  bool isLoading = false;

  @override
  void initState() {
    _userNameController =
        TextEditingController(text: widget.userModel.userName);

    _amazonController = TextEditingController(text: widget.userModel.amazon);

    _paypalController = TextEditingController(text: widget.userModel.paypal);

    _phoneController = TextEditingController(
        text: widget.userModel.number
            .replaceAll(widget.userModel.number.split(' ')[0], ''));
    _payoneerController =
        TextEditingController(text: widget.userModel.payoneer);
    countryName = widget.userModel.country;
    countryCode = widget.userModel.number.split(' ')[0];
    super.initState();
  }

  UploadFileServices _uploadFileServices = UploadFileServices();
  UserServices _userServices = UserServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Edit Profile", doestNotshow: true),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              VerticalSpace(20),
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: _file == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.userModel.dp ?? '',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/placeholderUser.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _file,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  ProfileImagePicker(() => getFile())
                ],
              ),
              TextFieldLabel("Username", isRequireLessPadding: true),
              VerticalSpace(10),
              AuthTextField(
                label: "",
                controller: _userNameController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              TextFieldLabel("Paypal", isRequireLessPadding: true),
              VerticalSpace(10),
              AuthTextField(
                label: "",
                controller: _paypalController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              TextFieldLabel("Payoneer", isRequireLessPadding: true),
              VerticalSpace(10),
              AuthTextField(
                label: "",
                controller: _payoneerController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              TextFieldLabel("Amazon Profile Link", isRequireLessPadding: true),
              VerticalSpace(10),
              AuthTextField(
                label: "",
                controller: _amazonController,
                validator: (val) =>
                    val.isEmpty ? "Field cannot be empty" : null,
                isRequireLessPadding: true,
              ),
              VerticalSpace(10),
              TextFieldLabel("Country", isRequireLessPadding: true),
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
                        countryName = country.displayNameNoCountryCode;
                        countryCode = country.phoneCode;
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
              VerticalSpace(10),
              TextFieldLabel("Phone Number"),
              VerticalSpace(10),
              _getPhoneField(),
              VerticalSpace(20),
              AppButton(
                  text: "Update Profile",
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    isLoading = true;
                    setState(() {});
                    if (_file != null) {
                      _uploadFileServices
                          .getUrl(context, file: _file)
                          .then((value) {
                        _userServices.editUserData(context,
                            uid: widget.userModel.uid,
                            model: UserModel(
                              dp: value,
                              userName: _userNameController.text,
                              payoneer: _payoneerController.text,
                              paypal: _paypalController.text,
                              amazon: _amazonController.text,
                              number: _phoneController.text,
                              country: countryName,
                            ));
                      }).then((value) {
                        isLoading = false;
                        setState(() {});
                        showNavigationDialog(context,
                            message: "Profile Updated successfully.",
                            buttonText: "Okay", navigation: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                              (route) => false);
                        },
                            secondButtonText: 'secondButtonText',
                            showSecondButton: false);
                      });
                    } else {
                      _userServices
                          .editUserData(context,
                              uid: widget.userModel.uid,
                              model: UserModel(
                                dp: widget.userModel.dp,
                                userName: _userNameController.text,
                                payoneer: _payoneerController.text,
                                paypal: _paypalController.text,
                                amazon: _amazonController.text,
                                number:
                                    "+$countryCode ${_phoneController.text}",
                                country: countryName,
                              ))
                          .then((value) {
                        isLoading = false;
                        setState(() {});
                        showNavigationDialog(context,
                            message: "Profile Updated successfully.",
                            buttonText: "Okay", navigation: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                              (route) => false);
                        },
                            secondButtonText: 'secondButtonText',
                            showSecondButton: false);
                      });
                    }
                  }),
              VerticalSpace(30),
            ],
          ),
        ),
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
                    countryCode,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
            HorizontalSpace(12),
            Expanded(
              child: Container(
                  height: 70,
                  child: TextFormField(
                    controller: _phoneController,
                    validator: (val) =>
                        val.isEmpty ? "Field cannot be empty" : null,
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
}
