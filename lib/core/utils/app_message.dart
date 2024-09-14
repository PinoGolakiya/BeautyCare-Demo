import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// <<< To show toast massage  --------- >>>
void showToast({required String message, required BuildContext context}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    textColor: Colors.white,
    backgroundColor: Colors.black26,
  );
}
