import 'dart:io';

import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/horizontal_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/profileTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned.fill(
              top: -100,
              right: -30,
              left: -30,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/profileBG.png',
                    fit: BoxFit.fitWidth,
                  ))),
          Positioned.fill(
            top: 0.14 * MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  _buildDP(),
                  VerticalSpace(10),
                  Text(
                    "Muhammad Arif",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  VerticalSpace(10),
                  Text(
                    "Seller",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              VerticalSpace(0.4 * MediaQuery.of(context).size.height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: FrontEndConfigs.appBaseColor,
                                size: 16,
                              ),
                              HorizontalSpace(6),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: FrontEndConfigs.appBaseColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ProfileTile(
                label: "Email",
                value: "kinmaker.ktk@gmail.com",
                icon: Icons.email_outlined,
              ),
              ProfileTile(
                label: "Paypal:",
                value: "kinmaker.ktk@gmail.com",
                iconString: "assets/icons/paypal.png",
              ),
              ProfileTile(
                label: "Amazon Profile Link:",
                value: "https://www.amazon.com",
                iconString: "assets/icons/amazon.png",
              ),
              ProfileTile(
                label: "Phone Number:",
                value: "03179570054",
                icon: Icons.phone_outlined,
              ),
              ProfileTile(
                label: "Country",
                value: "Pakistan",
                iconString: "assets/icons/globe.png",
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildDP() {
    return Stack(
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _image == null
                ? Image.asset('assets/images/user.png')
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned.fill(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  // getImage(true);
                },
                child: Container(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 17,
                  ),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: FrontEndConfigs.appBaseColor,
                      shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
