import 'package:jjimkong/common/services/dio_service.dart';
import 'package:jjimkong/map/models/place_details_model.dart';
import 'package:jjimkong/map/models/place_model.dart';
import 'package:jjimkong/map/models/place_review_model.dart';
import 'package:jjimkong/map/models/today_place_model.dart';

class MapService {
  static const COMMON_PATH = "/restaurant";

  /// [POST] 외식 장소 등록 메서드
  static Future<String?> postPlace(PlaceModel place) async {
    var response = await DioService().post("$COMMON_PATH/info", data: place);
    if (response.data != null && response.data is Map<String, dynamic>) {
      return response.data['restaurantId'] as String?;
    }
    return null;
  }

  /// [GET] 장소 전체 조회 메서드
  static Future<List<PlaceModel>> getAllPlaces() async {
    var response = await DioService().get("$COMMON_PATH/info");

    var places = (response.data as List)
        .map((item) => PlaceModel.fromJson(item))
        .toList();

    return places;
  }

  /// [GET] 장소 목록 조회(페이지) 메서드
  static Future<List<PlaceModel>> getPlaces({
    required String category,
    required int offset,
    required int limit,
  }) async {
    var response = await DioService().get(
      "$COMMON_PATH/info/page?category=$category&offset=$offset&limit=$limit",
    );

    var places = (response.data as List)
        .map((item) => PlaceModel.fromJson(item))
        .toList();

    return places;
  }

  /// [GET] 장소 상세 조회 메서드
  static Future<PlaceDetailsModel> getPlace({
    required String restaurantId,
  }) async {
    var response = await DioService().get(
      "$COMMON_PATH/info/details?restaurantId=$restaurantId",
    );

    var placeDetails = PlaceDetailsModel.fromJson(response.data);
    return placeDetails;
  }

  /// [POST] 장소 찜콩 메서드
  static Future<void> postPlaceJJimKong({
    required String restaurantId,
    required bool isChecked,
  }) async {
    await DioService().post(
        "$COMMON_PATH/check?restaurantId=$restaurantId&isChecked=$isChecked");
  }

  /// [GET] 오늘 찜콩 목록 조회 메서드
  static Future<List<TodayPlaceModel>> getTodayJJimKongList() async {
    var response = await DioService().get("$COMMON_PATH/check/list");
    var places = (response.data as List)
        .map((item) => TodayPlaceModel.fromJson(item))
        .toList();

    return places;
  }

  /// [POST] 장소 리뷰 작성 메서드
  static Future<int?> postReview(PlaceReviewModel review) async {
    var response = await DioService().post("$COMMON_PATH/review", data: review);
    return response.statusCode;
  }

  /// [GET] 리뷰 조회 메서드
  static Future<List<PlaceReviewModel>> getReviews(
      {required String restaurantId}) async {
    var response = await DioService()
        .get("$COMMON_PATH/review/list?restaurantId=$restaurantId");
    var reviews = (response.data as List)
        .map((item) => PlaceReviewModel.fromJson(item))
        .toList();

    return reviews;
  }
}
