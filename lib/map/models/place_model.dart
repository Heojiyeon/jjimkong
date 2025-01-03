class PlaceModel {
  String? restaurantId;
  String restaurantName, address, description, category, latitude, longitude;
  int? checkCount, positiveReviewCount, negativeReviewCount;

  PlaceModel({
    required this.restaurantName,
    required this.address,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  // PlaceModel 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "restaurantName": restaurantName,
      "address": address,
      "description": description,
      "category": category,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  // JSON 데이터를 PlaceModel 객체로 변환
  PlaceModel.fromJson(Map<String, dynamic> json)
      : restaurantName = json["restaurantName"],
        restaurantId = json["restaurantId"],
        address = json["address"],
        description = json["description"],
        category = json["category"],
        latitude = json["latitude"],
        longitude = json["longitude"],
        checkCount = int.tryParse(json["checkCount"].toString()) ?? 0,
        positiveReviewCount =
            int.tryParse(json["positiveReviewCount"].toString()) ?? 0,
        negativeReviewCount =
            int.tryParse(json["negativeReviewCount"].toString()) ?? 0;
}
