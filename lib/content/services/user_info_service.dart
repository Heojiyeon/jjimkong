import 'package:jjimkong/common/services/dio_service.dart';

Future<bool> getHasNickName() async {
  final response = await DioService().get('/login/nick-name/status');
  return response.data['hasNickName'];
}
