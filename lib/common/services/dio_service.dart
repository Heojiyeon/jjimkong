import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjimkong/common/services/handle_401_error.dart';
import 'package:jjimkong/common/widget/error_screen.dart';
import 'package:jjimkong/main.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late final dio.Dio _dio;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // 보안 스토리지

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _dio = dio.Dio();
    initialize();
  }

  void moveToLogin(String errorCode) {
    Main.navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ErrorScreen(errorCode: errorCode),
      ),
      (route) => false,
    );
  }

  // 기본 설정
  Future<void> initialize() async {
    // Secure Storage에서 accessToken 가져오기
    String? accessToken = await _secureStorage.read(key: 'accessToken');

    // TODO: Swagger 인증용 accessToken 확인
    print('accessToken: $accessToken');

    _dio.options = dio.BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onError: (dio.DioException error, handler) {
          switch (error.response?.statusCode) {
            case 401:
              handle401Error(error, handler);
              return;
            default:
              break;
          }
          moveToLogin(error.response?.statusCode.toString() ?? 'Unknown');
        },
      ),
    );
  }

  // GET 요청
  Future<dio.Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return Future.error(e);
    }
  }

  // POST 요청
  Future<dio.Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      return Future.error(e);
    }
  }

  // PUT 요청
  Future<dio.Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      return Future.error(e);
    }
  }

  // DELETE 요청
  Future<dio.Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      return Future.error(e);
    }
  }
}
