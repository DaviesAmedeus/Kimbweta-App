import 'package:flutter/material.dart';

import '../constants/constants.dart';

void showSnack(context, message) {
  if (context != null) {
    final snackBar = SnackBar(
      content: Text(message.toString()),
      backgroundColor: kMainThemeAppColor,
      duration: Duration(seconds: 5),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
