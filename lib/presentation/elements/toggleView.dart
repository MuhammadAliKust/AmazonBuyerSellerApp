import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleView extends StatelessWidget {
  final bool isSignIn;

  ToggleView(this.isSignIn);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSignIn
              ? Text(
                  "Don't have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .merge(TextStyle(fontSize: 14)),
                )
              : Text(
                  "Already have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .merge(TextStyle(fontSize: 14)),
                ),
          InkWell(
            onTap: () {
              isSignIn
                  ? NavigationHelper.pushReplacementName(
                      context, Routes.SIGN_UP_ROUTE, "")
                  : NavigationHelper.pushReplacementName(
                      context, Routes.LOGIN_ROUTE, "");
            },
            child: Text(
              isSignIn ? " Create Account" : " Login",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
