import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:amazon_sale_app/infrastructure/services/product_services.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/productCard.dart';
import 'package:amazon_sale_app/presentation/views/appViews/createPost.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:provider/provider.dart';

class MyProducts extends StatefulWidget {
  final bool fromNavbar;

  MyProducts({this.fromNavbar = false});

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  GlobalKey btnKey = GlobalKey();
  ProductServices _productServices = ProductServices();
  List<String> monthList = [
    "January",
    "February",
    "March",
  ];
  PopupMenu menu;

  @override
  void initState() {
    // TODO: implement initState
    menu = PopupMenu(
        items: [
          MenuItem(
              title: 'By Price',
              image: Icon(
                Icons.monetization_on_sharp,
                color: Colors.white,
              )),
          MenuItem(
              title: 'By Popularity',
              image: Icon(
                Icons.trending_up,
                color: Colors.white,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return Scaffold(
      appBar:
          customAppBar(context, title: "Home", doestNotshow: widget.fromNavbar),
      body: _getUI(context),
      drawer: !widget.fromNavbar ? AppDrawer() : null,
      bottomNavigationBar: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalSpace(20),
            AppButton(
                text: "Create Post",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreatePost()));
                }),
            VerticalSpace(20),
          ],
        ),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
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
                  suffix: InkWell(
                    key: btnKey,
                    onTap: () {
                      menu.show(widgetKey: btnKey);
                    },
                    child: Image.asset('assets/icons/filter.png'),
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedErrorBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Search your product here.."),
            ),
          ),
        ),
        VerticalSpace(10),
        StreamProvider.value(
          value: _productServices.streamAllProducts(user.getUserDetails.uid),
          builder: (context, child) {
            return Expanded(
              child: context.watch<List<ProductModel>>() == null
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context.watch<List<ProductModel>>().length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.55)),
                      itemBuilder: (context, i) {
                        return ProductCard(
                            context.watch<List<ProductModel>>()[i]);
                      }),
            );
          },
        ),
        VerticalSpace(20)
      ],
    );
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
}
