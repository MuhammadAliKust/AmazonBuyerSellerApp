// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson(data.uid));

class UserModel {
  UserModel({
    this.userName,
    this.email,
    this.password,
    this.country,
    this.number,
    this.paypal,
    this.isSeller,
    this.amazon,
    this.payoneer,
    this.uid,
  });

  String userName;
  String email;
  String password;
  String country;
  String number;
  String paypal;
  bool isSeller;
  String amazon;
  String payoneer;
  String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        country: json["country"],
        number: json["number"],
        paypal: json["paypal"],
        isSeller: json["isSeller"],
        amazon: json["amazon"],
        uid: json["uid"],
        payoneer: json["payoneer"],
      );

  Map<String, dynamic> toJson(String uid) => {
        "userName": userName,
        "email": email,
        "password": password,
        "country": country,
        "number": number,
        "paypal": paypal,
        "isSeller": isSeller,
        "amazon": amazon,
        "uid": uid,
        "payoneer": payoneer,
      };
}
