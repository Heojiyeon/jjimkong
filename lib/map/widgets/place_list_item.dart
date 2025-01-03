import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/map/screens/place_detail_screen.dart';
import 'package:jjimkong/map/utils/map_category.dart';

/// 장소 목록 아이템
/// 장소 목록 내부 아이템 요소 위젯입니다.
///
/// [placeName] 장소명
/// [category] 카테고리
/// [description] 장소 설명글
/// [visitorCount] 방문 예정자 수
///
class PlaceListItem extends StatelessWidget {
  final String placeId;
  final String placeName;
  final String category;
  final String description;
  final int visitorCount;

  const PlaceListItem({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.category,
    required this.description,
    required this.visitorCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.gray10,
            width: 1,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          navigateScreen(context,
              screen: PlaceDetailScreen(restaurantId: placeId));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  placeName,
                  style: AppStyles.highlightText,
                ),
                SizedBox(width: 4),
                Text(
                  MapCategory().findCategoryByCode(category),
                  style: AppStyles.defaultText.copyWith(color: AppColor.gray40),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              description.length > 55
                  ? "${description.substring(0, 55)}..."
                  : description,
              style: AppStyles.defaultText.copyWith(
                color: AppColor.gray90,
                letterSpacing: 0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "예상 방문 인원 $visitorCount명",
              style: AppStyles.subText.copyWith(color: AppColor.gray60),
            ),
          ],
        ),
      ),
    );
  }
}
