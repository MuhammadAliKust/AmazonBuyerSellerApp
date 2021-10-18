import 'package:amazon_sale_app/infrastructure/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel __userModel = UserModel();

  void setUserDetails(UserModel userModel) {
    print(userModel.toJson('uid'));
    __userModel = userModel;
    notifyListeners();
  }

  UserModel get getUserDetails => __userModel;
}
