import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
