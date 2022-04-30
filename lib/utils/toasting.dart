import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasting {
  static void notifyToast(BuildContext context, String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        fontSize: 16.0);
  }
}
