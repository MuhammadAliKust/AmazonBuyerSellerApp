import 'package:amazon_sale_app/application/app_state.dart';
import 'package:amazon_sale_app/infrastructure/models/add_money_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMoneyServices {
  ///Add Money
  Future<void> addMoney(BuildContext context, {AddMoney model}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('amazonAddMoneyCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }
}
