// To parse this JSON data, do
//
//     final addMoney = addMoneyFromJson(jsonString);

import 'dart:convert';

AddMoney addMoneyFromJson(String str) => AddMoney.fromJson(json.decode(str));

String addMoneyToJson(AddMoney data) => json.encode(data.toJson(data.docId));

class AddMoney {
  AddMoney({
    this.uid,
    this.docId,
    this.image,
    this.paypalAccount,
    this.payoneerAccount,
  });

  String uid;
  String docId;
  String image;
  String paypalAccount;
  String payoneerAccount;

  factory AddMoney.fromJson(Map<String, dynamic> json) => AddMoney(
        uid: json["uid"],
        docId: json["docID"],
        image: json["image"],
        paypalAccount: json["paypalAccount"],
        payoneerAccount: json["payoneerAccount"],
      );

  Map<String, dynamic> toJson(String docId) => {
        "uid": uid,
        "docID": docId,
        "image": image,
        "paypalAccount": paypalAccount,
        "payoneerAccount": payoneerAccount,
      };
}
