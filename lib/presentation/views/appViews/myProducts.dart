import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/productCard.dart';
import 'package:flutter/material.dart';

class MyProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Home"),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Image.asset('assets/icons/filter.png'),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedErrorBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: "Search your product here.."),
            ),
          ),
        ),
        VerticalSpace(10),
        Expanded(
          child: GridView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
              ),
              itemBuilder: (context, i) {
                return ProductCard();
              }),
        )
      ],
    );
  }
}
