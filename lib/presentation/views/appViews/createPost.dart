import 'dart:io';

import 'package:amazon_sale_app/application/app_state.dart';
import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/dialog.dart';
import 'package:amazon_sale_app/presentation/elements/dynamicFontSize.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

List<TeacherModel> _list = [
  TeacherModel(uid: "1", name: "XYZ"),
  TeacherModel(uid: "2", name: "ASD"),
  TeacherModel(uid: "3", name: "DFG"),
];

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _keywordController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _storeController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _totalReviewsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  TeacherModel _selectedTeacher;
  ProductServices _productServices = ProductServices();
  File _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Home"),
      drawer: AppDrawer(),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var status = Provider.of<AppState>(context);
    return LoadingOverlay(
      isLoading: status.getStateStatus() == StateStatus.IsBusy,
      child: Column(
        children: [
          HeaderEarningRow(),
          VerticalSpace(10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldLabel("Image", isRequireLessPadding: true),
                  VerticalSpace(10),
                  _getImagePicker(
                    context,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Keyword", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "T-Shirt",
                    controller: _keywordController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Description", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "Explain your product",
                    controller: _descriptionController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Category", isRequireLessPadding: true),
                  VerticalSpace(10),
                  _getSupervisorsDropwDown(hintText: "Category"),
                  VerticalSpace(10),
                  TextFieldLabel("Country", isRequireLessPadding: true),
                  VerticalSpace(10),
                  _getSupervisorsDropwDown(hintText: "Pakistan"),
                  VerticalSpace(10),
                  TextFieldLabel("Price", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "\$20",
                    controller: _priceController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Store", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "Alhamrah",
                    controller: _storeController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Link(optional)", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "https://www.google.com",
                    controller: _linkController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Select Review Type",
                      isRequireLessPadding: true),
                  VerticalSpace(10),
                  _getSupervisorsDropwDown(hintText: "Feedback"),
                  VerticalSpace(10),
                  TextFieldLabel("Total Reviews", isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "12",
                    controller: _totalReviewsController,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(10),
                  TextFieldLabel("Review needed on day:",
                      isRequireLessPadding: true),
                  VerticalSpace(10),
                  AuthTextField(
                    label: "Monday, Tuesday",
                    controller: _controller,
                    validator: (val) {},
                    isRequireLessPadding: true,
                  ),
                  VerticalSpace(20),
                  AppButton(
                      text: "Create Post",
                      onPressed: () async {
                        await _productServices
                            .createProduct(context,
                                model: ProductModel(
                                    uid: user.getUserDetails.uid,
                                    keyword: "Garments",
                                    productImage: "",
                                    refundImage: "",
                                    reviewImage: "",
                                    orderImage: "",
                                    isOrdered: false,
                                    isRefunded: false,
                                    isReviewed: false,
                                    country: "PK",
                                    price: "12",
                                    category: "Garments",
                                    store: "Jand Cash & Carry",
                                    link: "",
                                    reviewType: "feedback",
                                    totalReview: 12,
                                    day: [],
                                    fromId: ""))
                            .then((value) {
                          if (status.getStateStatus() == StateStatus.IsFree) {
                            pushNewScreen(context, screen: MyProducts());
                          } else if (status.getStateStatus() ==
                              StateStatus.IsError) {
                            showErrorDialog(context,
                                message: "An undefined error occured");
                          }
                        });
                      }),
                  VerticalSpace(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAttachmentContainer(BuildContext context,
      {String label, VoidCallback onTap}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: Container(
          height: 57,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.upload_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {})
                  ]),
            ),
          ),
        ));
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
                        ? "Upload Image"
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

  Widget _getSupervisorsDropwDown({String hintText}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<TeacherModel>(
            value: _selectedTeacher,
            items: _list.map((value) {
              return DropdownMenuItem<TeacherModel>(
                child: Text(value.name),
                value: value,
              );
            }).toList(),
            onChanged: (item) {
              _selectedTeacher = item;
              setState(() {});
            },
            underline: SizedBox(),
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}

class TeacherModel {
  final String uid;
  final String name;

  TeacherModel({this.uid, this.name});
}
