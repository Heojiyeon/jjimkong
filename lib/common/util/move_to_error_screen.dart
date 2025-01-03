import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/error_screen.dart';
import 'package:jjimkong/main.dart';

void moveToErrorScreen(String errorCode) {
  Main.navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => ErrorScreen(
        errorCode: errorCode,
      ),
    ),
    (route) => false,
  );
}
