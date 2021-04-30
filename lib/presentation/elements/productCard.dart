import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  height: 120,
                  // width: 147,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage('assets/images/shoe.png'),
                        fit: BoxFit.cover),
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
                    IconButton(
                        icon: Icon(Icons.copy, size: 17, color: Colors.black),
                        onPressed: () {})
                  ],
                ),
              ),
              Text(
                "Feedback",
                style: TextStyle(color: Color(0xff919191), fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$50.00",
                    style: TextStyle(
                        color: Color(0xffE76F25),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
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
}
