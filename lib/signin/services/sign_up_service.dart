import 'package:jjimkong/common/services/dio_service.dart';

/// 회원가입 관련 API
class SignUpService {
  /// [GET] - '/login/nick-name/exists'
  /// 유저의 닉네임 중복 여부를 확인한다.
  static Future<bool> getNicknameDuplication(String nickname) async {
    final response = await DioService().get('/login/nick-name/exists',
        queryParameters: {'nickName': nickname});
    return response.data['isDuplicatedNickName'];
  }

  /// [POST] - '/login/nick-name'
  /// 유저의 닉네임을 설정한다.
  static Future<void> postNickname(String nickname) async {
    await DioService().post(
      '/login/nick-name',
      data: {'nickName': nickname},
    );
  }

  /// [POST] - '/login/menu/job-scheduler'
  /// 메뉴 알림 등록(BullMq의 job scheduler 사용)
  static Future<void> postMenuJobScheduler() async {
    await DioService().post(
      '/login/menu/job-scheduler',
      data: {"cronTime": "0 11 * * 1-5"},
    );
  }

  static Future<void> postAllergy(List<String> allergies) async {
    await DioService().post(
      '/login/allergy',
      data: {"allergyInfo": allergies},
    );
  }
}
