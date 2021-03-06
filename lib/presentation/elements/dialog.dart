import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showErrorDialog(
  BuildContext context, {
  @required String message,
}) async {
  showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: Text(
            "Alert!",
            style: TextStyle(color: Colors.red),
          ),
          content: Text(message ?? "N/A"),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text("Okay"))
          ],
        );
      });
}
