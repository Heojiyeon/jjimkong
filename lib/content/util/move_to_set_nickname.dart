import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjimkong/content/screens/content.dart';
import 'package:jjimkong/content/services/user_info_service.dart';
import 'package:jjimkong/signin/screens/sign_up_nickname.dart';
import 'package:jjimkong/main.dart';

/// 닉네임 설정 여부에 따라서 닉네임 설정 화면으로 이동할지 판단 후 이동시킨다.
Future<void> moveToSetNickname() async {
  final storage = FlutterSecureStorage();

  // 이미 닉네임 설정 여부가 스토리지에 저장되어 있는 경우 (api 호출 최소화 목적)
  bool hasNickname = await storage.read(key: 'hasNickname') == 'true';
  if (!hasNickname) {
    // 서버를 통해서 닉네임이 이미 설정되어있는지 판단
    hasNickname = await getHasNickName();
    if (hasNickname) {
      await storage.write(key: 'hasNickname', value: 'true');
    }
  }
  ;

  // 이미 닉네임이 설정되어 있을 경우 메인 화면으로 이동
  // 닉네임이 설정되어 있지 않은 경우 닉네임 설정 화면으로 이동
  Main.navigatorKey.currentState?.push(
    MaterialPageRoute(
        builder: (context) => hasNickname ? Content() : SignUpNicknameScreen()),
  );
}
