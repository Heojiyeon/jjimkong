import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjimkong/signin/screens/sign_in.dart';
import 'package:jjimkong/main.dart';
import 'package:jjimkong/signin/services/auth_service.dart';

// 토큰 모두 삭제 후 로그인 화면으로 이동
Future<void> signOut() async {
  await FlutterSecureStorage().deleteAll();
  AuthService.hasToAuth = true;

  Main.navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => SignInScreen()),
    (route) => false, // 모든 이전 화면 제거
  );
}
