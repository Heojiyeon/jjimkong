import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jjimkong/common/services/dio_service.dart';
import 'package:jjimkong/common/util/move_to_error_screen.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // 보안 스토리지
final dio.Dio _dio = dio.Dio(
  dio.BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  ),
);

// 401 에러 발생 시 refreshToken을 사용하여 새로운 accessToken 요청
Future<void> handle401Error(
    dio.DioException error, dio.ErrorInterceptorHandler handler) async {
  final refreshToken = await _secureStorage.read(key: 'refreshToken');

// 리프레시 토큰이 없을 경우 에러페이지로 이동
  if (refreshToken == null) {
    moveToErrorScreen('Invalid');
    return;
  }

  try {
    final response = await _dio.get(
      '/login/access-token',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $refreshToken',
        },
      ),
    );

    final newAccessToken = response.data['accessToken'];
    final newRefreshToken = response.data['refreshToken'];

    await _secureStorage.write(key: 'accessToken', value: newAccessToken);
    await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);

    // DioService 초기화
    await DioService().initialize();

    // 새로운 accessToken으로 원래 요청 재시도
    final options = error.requestOptions;

    // 헤더에 새 accessToken 추가
    options.headers['Authorization'] = 'Bearer $newAccessToken';

    // Dio의 fetch 메서드를 사용하여 요청 재시도
    final retryResponse = await _dio.fetch(options);
    handler.resolve(retryResponse); // 요청 성공 시 원래 요청을 종료
    return;
  } catch (e) {
    moveToErrorScreen(e.toString());
    return;
  }
}
