import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final VoidCallback onTap;

  ProfileImagePicker(this.onTap);
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              child: Icon(
                Icons.image,
                color: Colors.white,
              ),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: FrontEndConfigs.appBaseColor,
                  shape: BoxShape.circle),
            ),
          ),
        ),
      ],
    ));
  }
}
