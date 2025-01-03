/// 장소 리뷰 객체
class PlaceReviewModel {
  String reviewContent;
  bool isPositiveReview;
  String? reviewId; // 리뷰 아이디
  String? restaurantId; // 장소 아이디
  String? nickName; // 작성자 닉네임
  String? createdAt; // 작성 시간

  PlaceReviewModel({
    this.restaurantId,
    required this.reviewContent,
    required this.isPositiveReview,
  });

  // TodayPlaceModel 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "restaurantId": restaurantId,
      "reviewContent": reviewContent,
      "isPositiveReview": isPositiveReview,
    };
  }

  // JSON 데이터를 PlaceReviewModel 객체로 변환
  PlaceReviewModel.fromJson(Map<String, dynamic> json)
      : reviewId = json["reviewId"],
        reviewContent = json["reviewContent"],
        restaurantId = json["restaurantId"],
        isPositiveReview = json["isPositiveReview"] as bool,
        nickName = json["nickName"],
        createdAt = json["createdAt"];
}
