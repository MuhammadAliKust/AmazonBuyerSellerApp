import 'package:amazon_sale_app/application/app_state.dart';
import 'package:amazon_sale_app/infrastructure/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserServices {
  ///Add User Details
  Future<void> addUserData(BuildContext context,
      {UserModel model, String uid}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('amazonUsersCollection').doc(uid);
    await docRef.set(model.toJson(uid));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Stream User Details
  Stream<UserModel> streamUserData(String docID) {
    print(docID);
    return FirebaseFirestore.instance
        .collection('amazonUsersCollection')
        .doc(docID)
        .snapshots()
        .map((snap) => UserModel.fromJson(snap.data()));
  }

  ///Edit User Details
  Future<void> editUserData(BuildContext context,
      {UserModel model, String uid}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('amazonUsersCollection').doc(uid);
    await docRef.update({
      'dp': model.dp,
      'userName': model.userName,
      'paypal': model.paypal,
      'payoneer': model.payoneer,
      'amazon': model.amazon,
      'country': model.country,
      'number': model.number,
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }
}
