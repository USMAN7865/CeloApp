import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessages(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        borderRadius: BorderRadius.circular(8),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        message: message,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        title: "Error",
        messageColor: Colors.white,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          color: Colors.white,
          size: 28,
        ),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }
  static void flushSucessMessages(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        borderRadius: BorderRadius.circular(8),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        message: message,
        backgroundColor: primaryColor,
        duration: Duration(seconds: 3),
        title: "Success",
        messageColor: Colors.white,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          color: Colors.white,
          size: 28,
        ),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }
  static snackBarMessage(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void fieldFocuschange(
      BuildContext context, FocusNode currentfocus, FocusNode nextfocus) {

    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }
}