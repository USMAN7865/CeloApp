 
import 'package:flutter/material.dart';

class EditTextUtils {
  TextFormField getCustomEditTextArea(
      {String labelValue = "",
      String hintValue = "",
      bool? validation,
      TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      TextStyle? textStyle,
      IconData? prefixIcon,
      double iconSize = 0.0,
      String? validationErrorMsg}) {
    TextFormField textFormField = TextFormField(
      keyboardType: keyboardType,
      style: textStyle,
      controller: controller,
      validator: (String? value) {
        if (validation!) {
          if (value!.isEmpty) {
            return validationErrorMsg;
          }
        }
      },
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(minWidth: iconSize),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
          size: 22,
        ),
        labelText: labelValue,
        hintText: hintValue,
        labelStyle: textStyle,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
    return textFormField;
  }
}