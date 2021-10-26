import 'dart:io';

import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/infrastructure/services/uploadFileServices.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/boldCaption.dart';
import 'package:amazon_sale_app/presentation/elements/bottomNavBar.dart';
import 'package:amazon_sale_app/presentation/elements/dynamicFontSize.dart';
import 'package:amazon_sale_app/presentation/elements/flushBar.dart';
import 'package:amazon_sale_app/presentation/elements/getReviewSS.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/lightCaption.dart';
import 'package:amazon_sale_app/presentation/elements/productNameTextStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SubmittedReview extends StatefulWidget {
  final ProductModel productModel;

  SubmittedReview(this.productModel);

  @override
  _SubmittedReviewState createState() => _SubmittedReviewState();
}

class _SubmittedReviewState extends State<SubmittedReview> {
  bool isLoading = false;
  UploadFileServices _uploadFileServices = UploadFileServices();
  File _file;
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Submitted Review"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Column(
        children: [
          HeaderEarningRow(),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.productModel.productImage,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  VerticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductNameTextStyle(widget.productModel.keyword),
                        LightCaption("04/04/21")
                      ],
                    ),
                  ),
                  VerticalSpace(7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldCaption("by ${widget.productModel.store}"),
                        LightCaption(
                            "ID: #${widget.productModel.docId.substring(0, 6).toUpperCase()}")
                      ],
                    ),
                  ),
                  VerticalSpace(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      widget.productModel.description ?? "N/A",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  VerticalSpace(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetReviewSS(widget.productModel.orderImage),
                          HorizontalSpace(10),
                          GetReviewSS(widget.productModel.reviewImage),
                        ],
                      ),
                    ),
                  ),
                  VerticalSpace(40),
                  _getImagePicker(context),
                  VerticalSpace(15),
                  AppButton(
                      text: "Submit",
                      onPressed: () async {
                        if (_file == null) {
                          getFlushBar(context,
                              title: "Kindly attach screenshot.",
                              icon: Icons.info_outline,
                              color: Colors.blue);
                          return;
                        }
                        isLoading = true;
                        setState(() {});
                        _uploadFileServices
                            .getUrl(context, file: _file)
                            .then((value) {
                          _productServices
                              .makeRefundedProduct(context,
                                  productID: widget.productModel.docId,
                                  refundImage: value)
                              .then((value) async {
                            isLoading = false;
                            setState(() {});
                            pushNewScreen(context,
                                screen: BottomNavBar(), withNavBar: false);
                          });
                        });
                      }),
                  VerticalSpace(15),
                ],
              ),
            ),
          ),
        ],
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
