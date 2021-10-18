// To parse this JSON data, do
//
//     final withdrawMoney = withdrawMoneyFromJson(jsonString);

import 'dart:convert';

WithdrawMoney withdrawMoneyFromJson(String str) =>
    WithdrawMoney.fromJson(json.decode(str));

String withdrawMoneyToJson(WithdrawMoney data) =>
    json.encode(data.toJson(data.docId));

class WithdrawMoney {
  WithdrawMoney({
    this.uid,
    this.docId,
    this.withdrawAmount,
    this.accountName,
    this.email,
  });

  String uid;
  String docId;
  String withdrawAmount;
  String accountName;
  String email;

  factory WithdrawMoney.fromJson(Map<String, dynamic> json) => WithdrawMoney(
        uid: json["uid"],
        docId: json["docID"],
        withdrawAmount: json["withdrawAmount"],
        accountName: json["accountName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "uid": uid,
        "docID": docID,
        "withdrawAmount": withdrawAmount,
        "accountName": accountName,
        "email": email,
      };
}
