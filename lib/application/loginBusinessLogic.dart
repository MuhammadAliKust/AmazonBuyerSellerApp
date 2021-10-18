import 'package:amazon_sale_app/application/userProvider.dart';
import 'package:amazon_sale_app/configurations/enums.dart';
import 'package:amazon_sale_app/infrastructure/services/authServices.dart';
import 'package:amazon_sale_app/infrastructure/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'errorStrings.dart';

class LoginBusinessLogic {
  UserServices _userServices = UserServices();
  final storage = new FlutterSecureStorage();

  Future loginUserLogic(
    BuildContext context, {
    @required String email,
    @required String password,
  }) async {
    var _authServices = Provider.of<AuthServices>(context, listen: false);
    var _error = Provider.of<ErrorString>(context, listen: false);
    var login = Provider.of<AuthServices>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    await login
        .signIn(context, email: email, password: password)
        .then((User user) async {
      if (user != null) {
        _userServices.streamUserData(user.uid).map((profileData) async {
          if (profileData == null) {
            _authServices.setState(Status.Unauthenticated);
          } else {
            print("HI I AM USER ${profileData.toJson(profileData.uid)}");
            userProvider.setUserDetails(profileData);
            // await storage.write(
            //     key: 'USER', value: profileData.toJson(user.uid).toString());
          }
        }).toList();
      } else {}
    });
  }
}
