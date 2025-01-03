import 'package:jjimkong/map/models/place_model.dart';

class PlaceDetailsModel {
  final PlaceModel place;
  final bool? isChecked;
  final bool? isReviewable;

  PlaceDetailsModel({
    this.isChecked,
    this.isReviewable,
    required this.place,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      place: PlaceModel.fromJson(
          json['restaurantDetails'] as Map<String, dynamic>),
      isChecked: json['isChecked'] != null ? json['isChecked'] as bool : null,
      isReviewable:
          json['isReviewable'] != null ? json['isReviewable'] as bool : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place.toJson(),
      'isChecked': isChecked,
      'isReviewable': isReviewable,
    };
  }
}
