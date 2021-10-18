import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'heigh_sized_box.dart';

class OrderedProductListTile extends StatelessWidget {
  final ProductModel productModel;

  OrderedProductListTile(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 115,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: productModel.productImage,
                  height: 109,
                  width: 116,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpace(10),
                              Text(
                                productModel.keyword,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              VerticalSpace(8),
                              Text(
                                "by ${productModel.store}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 10.0, horizontal: 8),
                        //   child: isTimer
                        //       ? Container(
                        //           height: 34,
                        //           width: 47,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10),
                        //               color: FrontEndConfigs.appBaseColor),
                        //           child: Center(
                        //             child: Text(
                        //               "29:30s",
                        //               style: TextStyle(
                        //                   fontSize: 10, color: Colors.white),
                        //             ),
                        //           ),
                        //         )
                        //       : Container(
                        //           height: 34,
                        //           width: 34,
                        //           decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: FrontEndConfigs.appBaseColor),
                        //           child: Center(
                        //             child: Icon(
                        //               Icons.check,
                        //               size: 26,
                        //             ),
                        //           ),
                        //         ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID: #${productModel.docId.toUpperCase().substring(0, 6)}",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff636363)),
                          ),
                          Text(
                            productModel.orderDate ?? "N/A",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xff636363)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
