class TodayPlaceModel {
  String restaurantId, restaurantName, address, category;
  int checkCount; // 오늘 찜콩 여부
  bool? reviewed; // 찜콩 후 리뷰여부

  TodayPlaceModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.address,
    required this.category,
    required this.checkCount,
    this.reviewed,
  });

  // TodayPlaceModel 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "restaurantId": restaurantId,
      "restaurantName": restaurantName,
      "address": address,
      "category": category,
      "checkCount": checkCount,
      "reviewed": reviewed,
    };
  }

  // JSON 데이터를 TodayPlaceModel 객체로 변환
  TodayPlaceModel.fromJson(Map<String, dynamic> json)
      : restaurantId = json["restaurantId"],
        restaurantName = json["restaurantName"],
        address = json["address"],
        category = json["category"],
        reviewed = json['reviewed'] != null ? json['reviewed'] as bool : null,
        checkCount = int.tryParse(json["checkCount"].toString()) ?? 0;
}
