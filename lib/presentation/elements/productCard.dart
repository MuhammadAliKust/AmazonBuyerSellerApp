import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/views/appViews/createPost.dart';
import 'package:amazon_sale_app/presentation/views/appViews/myProducts.dart';
import 'package:amazon_sale_app/presentation/views/appViews/profileView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  ProductCard(this.productModel);

  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Container(
      height: 240,
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BuyerProductScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: productModel.productImage,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      if (!user.getUserDetails.isSeller)
                        Positioned(
                          top: 10,
                          child: Container(
                            height: 33,
                            width: 54,
                            decoration: BoxDecoration(
                                color: FrontEndConfigs.appBaseColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: Center(
                              child: Text(
                                "Sale",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (!user.getUserDetails.isSeller)
                        Positioned.fill(
                          top: 10,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileView()));
                              },
                              child: Container(
                                height: 23,
                                width: 28,
                                decoration: BoxDecoration(
                                    color: Color(0xff812831),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    )),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.keyword,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Sold by ${productModel.store}",
                          style:
                              TextStyle(color: Color(0xff919191), fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.reviewType,
                    style: TextStyle(color: Color(0xff919191), fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      productModel.totalReview.toString(),
                      style: TextStyle(color: Color(0xff919191), fontSize: 12),
                    ),
                  ),
                ],
              ),
              VerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${productModel.price}",
                    style: TextStyle(
                        color: Color(0xffE76F25),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  myPopMenu(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myPopMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5.0),
      child: Container(
        height: 20,
        width: 20,
        child: PopupMenuButton(
            padding: EdgeInsets.symmetric(vertical: 6),
            icon: Icon(
              Icons.more_vert,
              size: 19,
              color: FrontEndConfigs.appBaseColor,
            ),
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePost(
                              productModel: productModel,
                              isUpdateView: true,
                            )));
              } else if (value == 2) {
                showDialog(
                    barrierDismissible: false,
                    context: (context),
                    builder: (dialogContext) {
                      return CupertinoAlertDialog(
                        title: Text(
                          "Message",
                          style: TextStyle(color: Colors.green[900]),
                        ),
                        content: Text(
                          "Do you really want to delete this product?",
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                _productServices.deleteProduct(context,
                                    categoryID: productModel.docId);
                                Navigator.pop(dialogContext);
                                pushNewScreen(context, screen: MyProducts());
                              },
                              child: Text("Yes")),
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: Text("No"))
                        ],
                      );
                    });
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: <Widget>[Text('Edit')],
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: <Widget>[Text('Delete')],
                      )),
                ]),
      ),
    );
  }
}
