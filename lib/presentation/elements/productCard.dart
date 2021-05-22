import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/views/appViews/buyerProductScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/profileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final bool isPosted;
  ProductCard(this.isPosted);
  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuyerProductScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        // width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage('assets/images/shoe.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
                          "Sports Shoes",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Sold by Alhamrah",
                          style:
                              TextStyle(color: Color(0xff919191), fontSize: 12),
                        ),
                      ],
                    ),
                    if (!isPosted)
                      IconButton(
                          icon: Icon(Icons.copy, size: 17, color: Colors.black),
                          onPressed: () {})
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Feedback",
                    style: TextStyle(color: Color(0xff919191), fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "12",
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
                    "\$50.00",
                    style: TextStyle(
                        color: Color(0xffE76F25),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  if (isPosted) myPopMenu(),
                  if (!isPosted)
                    Container(
                      width: 55,
                      height: 27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: FrontEndConfigs.appBaseColor),
                      child: Center(
                        child: Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myPopMenu() {
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
            onSelected: (value) {},
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
