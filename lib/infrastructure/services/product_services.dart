import 'package:amazon_sale_app/application/app_state.dart';
import 'package:amazon_sale_app/infrastructure/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductServices {
  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('amazonProductCollection');

  ///Create Product
  Future<void> createProduct(BuildContext context, {ProductModel model}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('amazonProductCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Get Product
  Stream<List<ProductModel>> streamAllProducts(String uid) {
    return _productCollection.where('uid', isEqualTo: uid).snapshots().map(
        (event) =>
            event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  ///Get Ordered Product
  Stream<List<ProductModel>> streamOrderedProduct(String uid) {
    return _productCollection
        .where('isOrdered', isEqualTo: true)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  ///Get Reviewed Product
  Stream<List<ProductModel>> streamReviewedProducts(String uid) {
    return _productCollection
        .where('isReviewed', isEqualTo: true)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  ///Get Refunded Product
  Stream<List<ProductModel>> streamRefundedProducts(String uid) {
    return _productCollection
        .where('isRefunded', isEqualTo: true)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  ///Update Product to Reviewed Product
  Future<void> makeReviewedProduct(
    BuildContext context, {
    String productID,
    String reviewImage,
  }) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _productCollection.doc(productID).update({
      'isReviewed': true,
      'reviewImage': reviewImage,
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Update Product to Refunded Product
  Future<void> makeRefundedProduct(BuildContext context,
      {String refundImage, String productID}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _productCollection.doc(productID).update({
      'isRefunded': true,
      'isReviewed': false,
      'refundImage': refundImage,
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Update Product to Ordered Product
  Future<void> makeOrderedProduct(
    BuildContext context, {
    String productID,
    String orderImage,
  }) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _productCollection.doc(productID).update({
      'isOrdered': true,
      'orderImage': orderImage,
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Update Product
  Future<void> updateProduct(BuildContext context,
      {String categoryID,
      String categoryName,
      String categoryImage,
      String chCategory}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _productCollection.doc(categoryID).update({
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'categoryNameChinese': chCategory
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Delete Product
  Future<void> deleteProduct(BuildContext context, {String categoryID}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _productCollection.doc(categoryID).delete();
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }
}
