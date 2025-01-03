import 'package:flutter/material.dart';

///
/// 화면 전환을 처리 유틸 함수
/// [context] 화면 전환을 실행하고자 하는 화면
/// [screen] 전환 하고자 하는 스크린
///
///
Future<void> navigateScreen(BuildContext context, {required Widget screen}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

////
/// 이전 화면으로 돌아가기 위한 유틸 함수
/// [context] 돌아가기 함수를 질행하고자 하는 화면
///
///
void navigateToBeforeScreen(BuildContext context) => Navigator.pop(context);
