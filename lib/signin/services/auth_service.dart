import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jjimkong/common/services/dio_service.dart';
import 'package:jjimkong/common/util/open_popup.dart';
import 'package:jjimkong/content/util/move_to_set_nickname.dart';

/// 로그인 인증 관련 API
class AuthService {
  /// Throttle 객체 생성 (3초 간격)
  static final Throttle<Function> _throttle = Throttle<Function>(
    Duration(seconds: 3),
    initialValue: () {},
    checkEquality: false,
  );

  /// 인증이 필요한 상태를 관리하는 변수
  static bool hasToAuth = true;

  /// [GET] - 'googleSignIn'
  /// 구글로부터 구글 accessToken을 발급받고 서버로부터 accessToken과 refreshToken을 발급받는다.
  static Future<void> googleAuthService(BuildContext context) async {
    if (!hasToAuth) return; // 인증이 필요하지 않은 경우 함수 종료

    hasToAuth = false; // 인증 시작

    _throttle.value = () async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final storage = FlutterSecureStorage();

      try {
        await googleSignIn.signOut();

        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        // 사용자가 로그인 과정을 취소한 경우
        if (googleUser == null) {
          hasToAuth = true; // 다시 인증이 필요하도록 설정
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? googleAccessToken = googleAuth.accessToken;

        final loginResponse = await signInService(googleAccessToken ?? '');

        // 응답에서 accessToken과 refreshToken을 추출
        final accessToken = loginResponse['accessToken'];
        final refreshToken = loginResponse['refreshToken'];

        // flutter_secure_storage에 저장
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);

        // 발급 받은 accessToken으로 DioService 초기화
        await DioService().initialize();

        moveToSetNickname();
      } catch (error) {
        hasToAuth = true; // 오류 발생 시에도 다시 인증이 필요하도록 설정

        if (context.mounted) {
          openPopup(
            context,
            title: '로그인 실패',
            firstLineContent: 'JEI 사원만 로그인 가능합니다.',
            secondLineContent: '문의: JEI 교육시스템팀',
            onPressedCheckButton: () {
              Navigator.pop(context);
            },
          );
        }
      }
    };

    _throttle.value();
  }

  /// [GET] - '/login/google'
  /// 구글 accessToken을 통해 서버로부터 accessToken과 refreshToken을 발급받는다.
  static Future<Map<String, dynamic>> signInService(
      String googleAccessToken) async {
    // 구글 accessToken을 통한 인증이기 때문에 DioService를 사용하지 않는다.
    final dioInstance = dio.Dio();

    try {
      final response = await dioInstance.get(
        '${dotenv.env['BASE_URL']}/login/google',
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': googleAccessToken,
          },
        ),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
