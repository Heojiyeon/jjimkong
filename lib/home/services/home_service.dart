import 'package:jjimkong/common/services/dio_service.dart';

class HomeService {
  static const COMMON_PATH = '/main';

  /// [POST] 메뉴 찜콩
  static Future<void> postMenuCheck({
    required String menuId,
    required bool isChecked,
  }) async {
    await DioService()
        .post("$COMMON_PATH/menu/check?menuId=$menuId&isChecked=$isChecked");
  }

  /// [POST] 메뉴 찜콩
  static Future<void> postMenuEaten({
    required String menuId,
    required bool isMenuEaten,
  }) async {
    await DioService()
        .post("$COMMON_PATH/eaten?menuId=$menuId&isMenuEaten=$isMenuEaten");
  }

  /// [GET] 이번주 메뉴 조회
  static Future<List<dynamic>> getMenuInfoWeekly() async {
    var response = await DioService().get("$COMMON_PATH/menu/info/weekly");

    return response.data;
  }

  /// [GET] 다음주 메뉴 조회
  static Future<List<dynamic>> getMenuInfoNext() async {
    var response = await DioService().get("$COMMON_PATH/next/menu/info/weekly");

    return response.data;
  }
}
