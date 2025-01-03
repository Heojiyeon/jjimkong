import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/models/place_details_model.dart';
import 'package:jjimkong/map/widgets/place_detail_item.dart';
import 'package:jjimkong/map/widgets/review_list.dart';

/// 장소 상세 정보 페이지
class PlaceDetailScreen extends StatelessWidget {
  final String restaurantId;

  PlaceDetailScreen({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: "장소 상세"),
      body: BaseLayout(
        hasHorizontalPadding: true,
        hasTopPadding: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FutureBuilder<PlaceDetailsModel>(
              future: MapService.getPlace(restaurantId: restaurantId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('존재하지 않는 장소 입니다.'));
                }

                var placeDetails = snapshot.data!;
                var place = placeDetails.place;

                return Column(
                  spacing: 36,
                  children: [
                    PlaceDetailItem(
                      isBottomSheet: false,
                      id: place.restaurantId!,
                      placeName: place.restaurantName,
                      category: place.category,
                      address: place.address,
                      description: place.description,
                      expectedVisitors: place.checkCount ?? 0,
                      isChecked: placeDetails.isChecked,
                      isReviewable: placeDetails.isReviewable,
                    ),
                    ReviewList(
                      positiveCount: place.positiveReviewCount ?? 0,
                      negativeCount: place.negativeReviewCount ?? 0,
                      placeId: place.restaurantId!,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
