import 'dart:io';

import 'package:amazon_sale_app/application/app_state.dart';
import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/infrastructure/services/uploadFileServices.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/dialog.dart';
import 'package:amazon_sale_app/presentation/elements/dynamicFontSize.dart';
import 'package:amazon_sale_app/presentation/elements/flushBar.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
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
  final ProductModel productModel;
  final bool isUpdateView;

  CreatePost({this.productModel, this.isUpdateView = false});

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
  String _selctedCategory;
  String _selectedReviewType;
  List<dynamic> _selectedDays = [];
  List<dynamic> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<String> categoryList = [
    "Electronices",
    "Baby",
    "Garments",
  ];
  List<String> reviewTypeList = [
    "Feedback",
    "Review",
    "Order",
  ];
  String countryName;
  String _fileUrl;
  TeacherModel _selectedTeacher;
  ProductServices _productServices = ProductServices();
  UploadFileServices _uploadFileServices = UploadFileServices();
  File _file;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isUpdateView) {
      _keywordController =
          TextEditingController(text: widget.productModel.keyword);
      _priceController = TextEditingController(text: widget.productModel.price);
      _storeController = TextEditingController(text: widget.productModel.store);
      _linkController = TextEditingController(text: widget.productModel.link);
      _totalReviewsController = TextEditingController(
          text: widget.productModel.totalReview.toString());
      _descriptionController =
          TextEditingController(text: widget.productModel.description);
      _selctedCategory = widget.productModel.category;
      _selectedReviewType = widget.productModel.reviewType;
      _selectedDays = widget.productModel.day;
      countryName = widget.productModel.country;
      _fileUrl = widget.productModel.productImage;
      setState(() {});
    }
    super.initState();
  }

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
      isLoading: isLoading,
      child: Form(
        key: _formKey,
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
                    if (_file == null)
                      if (_fileUrl != null)
                        _getImages(context, widget.productModel.productImage),
                    VerticalSpace(10),
                    TextFieldLabel("Keyword", isRequireLessPadding: true),
                    VerticalSpace(10),
                    AuthTextField(
                      label: "T-Shirt",
                      controller: _keywordController,
                      validator: (val) =>
                          val.isEmpty ? "Field cannot be empty" : null,
                      isRequireLessPadding: true,
                    ),
                    VerticalSpace(10),
                    TextFieldLabel("Description", isRequireLessPadding: true),
                    VerticalSpace(10),
                    AuthTextField(
                      label: "Explain your product",
                      controller: _descriptionController,
                      validator: (val) =>
                          val.isEmpty ? "Field cannot be empty" : null,
                      isRequireLessPadding: true,
                    ),
                    VerticalSpace(10),
                    TextFieldLabel("Category", isRequireLessPadding: true),
                    VerticalSpace(10),
                    _getCategoryDropDown(),
                    VerticalSpace(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4),
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
                    TextFieldLabel("Price", isRequireLessPadding: true),
                    VerticalSpace(10),
                    AuthTextField(
                      label: "\$20",
                      controller: _priceController,
                      isNumberField: true,
                      validator: (val) =>
                          val.isEmpty ? "Field cannot be empty" : null,
                      isRequireLessPadding: true,
                    ),
                    VerticalSpace(10),
                    TextFieldLabel("Store", isRequireLessPadding: true),
                    VerticalSpace(10),
                    AuthTextField(
                      label: "Alhamrah",
                      controller: _storeController,
                      validator: (val) =>
                          val.isEmpty ? "Field cannot be empty" : null,
                      isRequireLessPadding: true,
                    ),
                    VerticalSpace(10),
                    TextFieldLabel("Link(optional)",
                        isRequireLessPadding: true),
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
                    _getFeedbackDropDown(),
                    VerticalSpace(10),
                    TextFieldLabel("Total Reviews", isRequireLessPadding: true),
                    VerticalSpace(10),
                    AuthTextField(
                      label: "12",
                      controller: _totalReviewsController,
                      isNumberField: true,
                      validator: (val) =>
                          val.isEmpty ? "Field cannot be empty" : null,
                      isRequireLessPadding: true,
                    ),
                    VerticalSpace(10),
                    TextFieldLabel("Review needed on day:",
                        isRequireLessPadding: true),
                    VerticalSpace(10),
                    _getDaysList(),
                    VerticalSpace(20),
                    AppButton(
                        text: "Create Post",
                        onPressed: () async {
                          if (widget.isUpdateView) {
                            _updatePost();
                          } else {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            if (_file == null) {
                              getFlushBar(context,
                                  title: "Kindly select image.",
                                  icon: Icons.info_outline,
                                  color: Colors.blue);
                              return;
                            }
                            if (_selctedCategory == null) {
                              getFlushBar(context,
                                  title: "Kindly select category.",
                                  icon: Icons.info_outline,
                                  color: Colors.blue);
                              return;
                            }
                            if (countryName == null) {
                              getFlushBar(context,
                                  title: "Kindly select country.",
                                  icon: Icons.info_outline,
                                  color: Colors.blue);
                              return;
                            }
                            if (_selectedReviewType == null) {
                              getFlushBar(context,
                                  title: "Kindly select review type.",
                                  icon: Icons.info_outline,
                                  color: Colors.blue);
                              return;
                            }
                            if (_selectedDays.isEmpty) {
                              getFlushBar(context,
                                  title: "Kindly select day.",
                                  icon: Icons.info_outline,
                                  color: Colors.blue);
                              return;
                            }
                            isLoading = true;
                            setState(() {});
                            await _uploadFileServices
                                .getUrl(context, file: _file)
                                .then((value) async {
                              await _productServices.createProduct(context,
                                  model: ProductModel(
                                      uid: user.getUserDetails.uid,
                                      keyword: _keywordController.text,
                                      productImage: value,
                                      refundImage: "",
                                      reviewImage: "",
                                      orderImage: "",
                                      isOrdered: false,
                                      description: _descriptionController.text,
                                      isRefunded: false,
                                      isReviewed: false,
                                      country: countryName,
                                      price: _priceController.text,
                                      category: _selctedCategory,
                                      store: _storeController.text,
                                      link: _linkController.text,
                                      reviewType: _selectedReviewType,
                                      totalReview: int.parse(
                                          _totalReviewsController.text),
                                      day: _selectedDays,
                                      fromId: ""));
                            }).then((value) {
                              if (status.getStateStatus() ==
                                  StateStatus.IsFree) {
                                isLoading = false;
                                setState(() {});
                                pushNewScreen(context, screen: MyProducts());
                              } else if (status.getStateStatus() ==
                                  StateStatus.IsError) {
                                showErrorDialog(context,
                                    message: "An undefined error occured");
                              }
                            });
                          }
                        }),
                    VerticalSpace(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updatePost() async {
    var status = Provider.of<AppState>(context, listen: false);
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_selctedCategory == null) {
      getFlushBar(context,
          title: "Kindly select category.",
          icon: Icons.info_outline,
          color: Colors.blue);
      return;
    }
    if (countryName == null) {
      getFlushBar(context,
          title: "Kindly select country.",
          icon: Icons.info_outline,
          color: Colors.blue);
      return;
    }
    if (_selectedReviewType == null) {
      getFlushBar(context,
          title: "Kindly select review type.",
          icon: Icons.info_outline,
          color: Colors.blue);
      return;
    }
    if (_selectedDays.isEmpty) {
      getFlushBar(context,
          title: "Kindly select day.",
          icon: Icons.info_outline,
          color: Colors.blue);
      return;
    }
    isLoading = true;
    setState(() {});
    if (_file == null) {
      await _productServices
          .updateProduct(context,
              model: ProductModel(
                docId: widget.productModel.docId,
                keyword: _keywordController.text,
                productImage: widget.productModel.productImage,
                description: _descriptionController.text,
                country: countryName,
                price: _priceController.text,
                category: _selctedCategory,
                store: _storeController.text,
                link: _linkController.text,
                reviewType: _selectedReviewType,
                totalReview: int.parse(_totalReviewsController.text),
                day: _selectedDays,
              ))
          .then((value) {
        if (status.getStateStatus() == StateStatus.IsFree) {
          isLoading = false;
          setState(() {});
          pushNewScreen(context, screen: MyProducts());
        } else if (status.getStateStatus() == StateStatus.IsError) {
          showErrorDialog(context, message: "An undefined error occured");
        }
      });
    } else {
      await _uploadFileServices
          .getUrl(context, file: _file)
          .then((value) async {
        await _productServices.updateProduct(context,
            model: ProductModel(
              docId: widget.productModel.docId,
              keyword: _keywordController.text,
              productImage: value,
              description: _descriptionController.text,
              country: countryName,
              price: _priceController.text,
              category: _selctedCategory,
              store: _storeController.text,
              link: _linkController.text,
              reviewType: _selectedReviewType,
              totalReview: int.parse(_totalReviewsController.text),
              day: _selectedDays,
            ));
      }).then((value) {
        if (status.getStateStatus() == StateStatus.IsFree) {
          isLoading = false;
          setState(() {});
          pushNewScreen(context, screen: MyProducts());
        } else if (status.getStateStatus() == StateStatus.IsError) {
          showErrorDialog(context, message: "An undefined error occured");
        }
      });
    }
  }

  _getImages(BuildContext context, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Stack(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: FrontEndConfigs.appBaseColor),
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _fileUrl = null;
                    setState(() {});
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.clear,
                        size: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDaysList() {
    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: days.length,
          itemBuilder: (context, i) {
            return Row(
              children: [
                if (i == 0) HorizontalSpace(18),
                _getDaysContainer(days[i])
              ],
            );
          }),
    );
  }

  _getDaysContainer(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          if (!_selectedDays.contains(day)) {
            _selectedDays.add(day);
          } else {
            _selectedDays.remove(day);
          }
          setState(() {});
        },
        child: Container(
          height: 48,
          width: 68,
          child: Center(
            child: Text(day),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(8),
              color: _selectedDays.contains(day)
                  ? FrontEndConfigs.appBaseColor
                  : Colors.grey),
        ),
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

  Widget _getCategoryDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
            value: _selctedCategory,
            items: categoryList.map((value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (item) {
              _selctedCategory = item;
              setState(() {});
            },
            underline: SizedBox(),
            hint: Text(
              "Categories",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            isExpanded: true,
          ),
        ),
      ),
    );
  }

  Widget _getFeedbackDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
            value: _selectedReviewType,
            items: reviewTypeList.map((value) {
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (item) {
              _selectedReviewType = item;
              setState(() {});
            },
            underline: SizedBox(),
            hint: Text(
              "Review Type",
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
