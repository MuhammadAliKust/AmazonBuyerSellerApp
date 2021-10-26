import 'package:amazon_sale_app/configurations/frontEndConfigs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) validator;
  final IconData icon;
  final bool isRequireLessPadding;
  final bool isNumberField;

  AuthTextField(
      {@required this.label,
      @required this.controller,
      @required this.validator,
      this.isRequireLessPadding = false,
      this.isNumberField = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    ///common textField border
    OutlineInputBorder authTextFieldBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor));

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isRequireLessPadding ? 18 : 30.0, vertical: 4),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          if (isNumberField) FilteringTextInputFormatter.allow(RegExp("[0-9]"))
        ],
        keyboardType: isNumberField ? TextInputType.number : TextInputType.text,
        validator: validator,
        cursorColor: FrontEndConfigs.appBaseColor,
        style: TextStyle(color: FrontEndConfigs.appBaseColor),
        decoration: InputDecoration(
          suffixIcon: icon != null
              ? Icon(
                  icon,
                  color: FrontEndConfigs.appBaseColor,
                  size: 20,
                )
              : null,
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: authTextFieldBorder,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border: authTextFieldBorder,
        ),
      ),
    );
  }
}
