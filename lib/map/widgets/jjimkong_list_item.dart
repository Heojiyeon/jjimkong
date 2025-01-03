import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/map/screens/place_detail_screen.dart';
import 'package:jjimkong/map/screens/review_registration_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/widgets/jjimkong_button.dart';

/// 오늘 찜콩 목록 아이템
/// 장소 목록 내부 아이템 요소 위젯입니다.
///
/// [id] 장소명
/// [placeName] 장소명
/// [category] 카테고리
/// [description] 장소 설명글
/// [visitorCount] 방문 예정자 수
///
class TodayListItem extends StatelessWidget {
  final String id;
  final String placeName;
  final String category;
  final String address;
  final int visitorCount;
  final bool? hasWrittenReview;
  final void Function() callback;

  const TodayListItem({
    super.key,
    required this.id,
    required this.placeName,
    required this.category,
    required this.address,
    required this.visitorCount,
    this.hasWrittenReview,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.gray10,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    placeName,
                    style: AppStyles.highlightText,
                  ),
                  Text(
                    category,
                    style: AppStyles.subText.copyWith(
                      color: AppColor.gray40,
                    ),
                  ),
                ],
              ),
              Text(
                address,
                style: AppStyles.subText.copyWith(color: AppColor.gray60),
              ),
            ],
          ),
          Column(
            spacing: 0,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              JJimKongButton(
                type: hasWrittenReview == null
                    ? ButtonType.cancel
                    : ButtonType.review,
                onPressed: () {
                  // 취소 가능한 상태라면 취소
                  if (hasWrittenReview == null) {
                    MapService.postPlaceJJimKong(
                        restaurantId: id, isChecked: false);
                    callback();
                    return;
                  }

                  navigateScreen(context,
                      screen: hasWrittenReview!
                          ? PlaceDetailScreen(restaurantId: id)
                          : ReviewRegistrationScreen(
                              restaurantId: id,
                              placeName: placeName,
                              address: address,
                            ));
                },
                isChecked: true,
              ),
              if (hasWrittenReview == null)
                Text(
                  "현재 $visitorCount 찜콩중",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Pretendard",
                    color: AppColor.gray40,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
