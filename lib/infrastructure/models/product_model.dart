// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
    json.encode(data.toJson(data.docId));

class ProductModel {
  ProductModel({
    this.uid,
    this.description,
    this.docId,
    this.fromId,
    this.productImage,
    this.keyword,
    this.category,
    this.country,
    this.price,
    this.store,
    this.link,
    this.reviewType,
    this.totalReview,
    this.day,
    this.isRefunded,
    this.isOrdered,
    this.isReviewed,
    this.refundImage,
    this.reviewImage,
    this.orderImage,
    this.orderDate,
    this.reviewDate,
    this.refundDate,
  });

  String uid;
  String docId;
  String fromId;
  String productImage;
  String keyword;
  String category;
  String country;
  String price;
  String store;
  String link;
  String description;
  String reviewType;
  int totalReview;
  List<dynamic> day;
  bool isRefunded;
  bool isOrdered;
  bool isReviewed;
  String refundImage;
  String reviewImage;
  String orderImage;
  String orderDate;
  String reviewDate;
  String refundDate;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        uid: json["uid"],
        docId: json["docID"],
        fromId: json["fromID"],
        productImage: json["productImage"],
        keyword: json["keyword"],
        category: json["category"],
        country: json["country"],
        price: json["price"],
        store: json["store"],
        link: json["link"],
        description: json["description"],
        reviewType: json["reviewType"],
        totalReview: json["totalReview"],
        day: List<dynamic>.from(json["day"].map((x) => x)),
        isRefunded: json["isRefunded"],
        isOrdered: json["isOrdered"],
        isReviewed: json["isReviewed"],
        refundImage: json["refundImage"],
        reviewImage: json["reviewImage"],
        orderImage: json["orderImage"],
        refundDate: json["refundDate"],
        orderDate: json["orderDate"],
        reviewDate: json["reviewDate"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "uid": uid,
        "docID": docID,
        "fromID": fromId,
        "productImage": productImage,
        "keyword": keyword,
        "category": category,
        "country": country,
        "price": price,
        "store": store,
        "link": link,
        "reviewType": reviewType,
        "totalReview": totalReview,
        "day": List<dynamic>.from(day.map((x) => x)),
        "isRefunded": isRefunded,
        "isOrdered": isOrdered,
        "isReviewed": isReviewed,
        "refundImage": refundImage,
        "reviewImage": reviewImage,
        "orderImage": orderImage,
        "refundDate": refundDate,
        "orderDate": orderDate,
        "reviewDate": reviewDate,
        "description": description,
      };
}
