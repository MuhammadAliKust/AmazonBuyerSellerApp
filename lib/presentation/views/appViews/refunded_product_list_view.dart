import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/refunded_product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefundedProductListView extends StatelessWidget {
  final ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Ordered Products"),
      drawer: AppDrawer(),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(10),
        Expanded(
          child: StreamProvider.value(
            value: _productServices
                .streamRefundedProducts(user.getUserDetails.uid),
            builder: (context, child) {
              return context.watch<List<ProductModel>>() == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context.watch<List<ProductModel>>().length,
                      itemBuilder: (context, i) {
                        return RefundedProductListTile(
                            context.watch<List<ProductModel>>()[i]);
                      });
            },
          ),
        )
      ],
    );
  }
}
