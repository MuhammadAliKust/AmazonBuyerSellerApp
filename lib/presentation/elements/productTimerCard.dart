import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/material.dart';

import 'heigh_sized_box.dart';

class ProductTimerCard extends StatelessWidget {
  final bool isTimer;
  ProductTimerCard({this.isTimer = true});
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
              Container(
                height: 109,
                width: 116,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/shoe.png'))),
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
                                "Head Phones",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              VerticalSpace(8),
                              Text(
                                "by Alhamrah",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8),
                          child: isTimer
                              ? Container(
                                  height: 34,
                                  width: 47,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: FrontEndConfigs.appBaseColor),
                                  child: Center(
                                    child: Text(
                                      "29:30s",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: FrontEndConfigs.appBaseColor),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 26,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID: #1234556",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff636363)),
                          ),
                          Text(
                            "04/04/21",
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
