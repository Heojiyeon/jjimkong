import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjimkong/common/services/dio_service.dart';
import 'package:jjimkong/common/widget/error_screen.dart';
import 'package:jjimkong/content/screens/content.dart';
import 'package:jjimkong/signin/screens/sign_in.dart';
import 'package:jjimkong/signin/screens/sign_up_nickname.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  AuthRepository.initialize(
      appKey: dotenv.env['KAKAKOMAP_API_KEY'] ?? '',
      baseUrl: dotenv.env['KAKOMAP_BASE_URL'] ?? '');

  final storage = FlutterSecureStorage();
  String? accessToken = await storage.read(key: 'accessToken');
  String? refreshToken = await storage.read(key: 'refreshToken');

  DioService().initialize();

  runApp(Main(hasToLogin: accessToken == null && refreshToken == null));
}

class Main extends StatelessWidget {
  final bool hasToLogin;

  // 전역 Navigator Key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const Main({
    super.key,
    this.hasToLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey, // 전역 Navigator Key 설정
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: hasToLogin ? SignInScreen() : Content(),
        routes: {
          '/error': (context) => const ErrorScreen(),
          '/content': (context) => Content(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpNicknameScreen(),
        });
  }
}
