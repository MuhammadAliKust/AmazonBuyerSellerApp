import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/boldCaption.dart';
import 'package:amazon_sale_app/presentation/elements/getReviewSS.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/lightCaption.dart';
import 'package:amazon_sale_app/presentation/elements/productNameTextStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RefundedProduct extends StatelessWidget {
  final ProductModel productModel;

  RefundedProduct(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Refunded Product"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
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
                    imageUrl: productModel.productImage,
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
                      ProductNameTextStyle(productModel.keyword),
                      LightCaption(productModel.refundDate ?? "N/A")
                    ],
                  ),
                ),
                VerticalSpace(7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldCaption("by ${productModel.store}"),
                      LightCaption("ID: #${productModel.docId.substring(0, 6)}")
                    ],
                  ),
                ),
                VerticalSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    productModel.description ?? "N/A",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                VerticalSpace(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetReviewSS(productModel.orderImage),
                        HorizontalSpace(10),
                        GetReviewSS(productModel.reviewImage),
                        HorizontalSpace(10),
                        GetReviewSS(productModel.refundImage),
                      ],
                    ),
                  ),
                ),
                VerticalSpace(40),
                Image.asset('assets/images/emoji.png'),
                VerticalSpace(15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
