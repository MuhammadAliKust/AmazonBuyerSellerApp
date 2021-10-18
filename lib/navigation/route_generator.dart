import 'package:amazon_sale_app/presentation/elements/bottomNavBar.dart';
import 'package:amazon_sale_app/presentation/views/appViews/addMoney.dart';
import 'package:amazon_sale_app/presentation/views/appViews/buyerProductScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/chat.dart';
import 'package:amazon_sale_app/presentation/views/appViews/createPost.dart';
import 'package:amazon_sale_app/presentation/views/appViews/howToUse.dart';
import 'package:amazon_sale_app/presentation/views/appViews/notifications.dart';
import 'package:amazon_sale_app/presentation/views/appViews/orderedProductScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/productCheckedScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/productTimerScreen.dart';
import 'package:amazon_sale_app/presentation/views/appViews/profileView.dart';
import 'package:amazon_sale_app/presentation/views/appViews/submittedSSfromBuyer.dart';
import 'package:amazon_sale_app/presentation/views/appViews/withdrawMoney.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/forgotPassword.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/login.dart';
import 'package:amazon_sale_app/presentation/views/authVIews/registerView.dart';
import 'package:flutter/material.dart';

import 'route_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.SIGN_UP_ROUTE:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.FORGOT_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ForgotPasswordViews());
      case Routes.DASHBOARD_ROUTE:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case Routes.ADD_MONEY_ROUTE:
        return MaterialPageRoute(builder: (_) => AddMoneyView());
      case Routes.CREATE_POST_ROUTE:
        return MaterialPageRoute(builder: (_) => CreatePost());
      case Routes.BUYER_PRODUCT_ROUTE:
        return MaterialPageRoute(builder: (_) => BuyerProductScreen());
      case Routes.CHAT_ROUTE:
        return MaterialPageRoute(builder: (_) => MessagesScreen());
      case Routes.PROFILE_ROUTE:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.HOW_TO_USE_ROUTE:
        return MaterialPageRoute(builder: (_) => HowToUse());
      // case Routes.MY_PRODUCTS_ROUTE:
      //   return MaterialPageRoute(builder: (_) => MyProducts());
      case Routes.NOTIFICATIONS_ROUTE:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case Routes.ORDERED_PRODUCTS_ROUTE:
        return MaterialPageRoute(builder: (_) => OrderedProductScreen());
      case Routes.PRODUCT_CHECKED_ROUTE:
        return MaterialPageRoute(builder: (_) => OrderedProductListView());
      case Routes.PRODUCT_TIMER_ROUTE:
        return MaterialPageRoute(builder: (_) => ProductTimerView());
      // case Routes.REFUNDED_PRODUCT_ROUTE:
      //   return MaterialPageRoute(builder: (_) => RefundedProduct());
      // case Routes.SUBMIT_REVIEW_ROUTE:
      //   return MaterialPageRoute(builder: (_) => SubmittedReview());
      case Routes.SUBMIT_SS_ROUTE:
        return MaterialPageRoute(
            builder: (_) => SubmittedScreenShotFromBuyer());
      case Routes.WITHDRAW_MONEY_ROUTE:
        return MaterialPageRoute(builder: (_) => WithdrawMoneyView());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
