import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/map/screens/review_registration_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/utils/map_category.dart';
import 'package:jjimkong/map/widgets/jjimkong_button.dart';

/// 장소 상세 아이템
///
/// [placeName] 장소 이름
/// [category] 카테고리
/// [address] 주소
/// [description] 설명글
/// [expectedVisitors] 방문 예정수
class PlaceDetailItem extends StatefulWidget {
  final isBottomSheet;
  final String id, placeName, category, address, description;
  final int expectedVisitors;
  final bool? isChecked, isReviewable;

  const PlaceDetailItem({
    super.key,
    required this.id,
    required this.isBottomSheet,
    required this.placeName,
    required this.category,
    required this.address,
    required this.description,
    required this.expectedVisitors,
    this.isChecked,
    this.isReviewable,
  });

  @override
  State<PlaceDetailItem> createState() => _PlaceDetailItemState();
}

class _PlaceDetailItemState extends State<PlaceDetailItem> {
  bool? _isChecked;

  @override
  void didUpdateWidget(covariant PlaceDetailItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isReviewable != null) {
      _isChecked = widget.isReviewable;
      return;
    }

    _isChecked = widget.isChecked;
  }

  @override
  void initState() {
    super.initState();

    if (widget.isReviewable != null) {
      _isChecked = widget.isReviewable;
      return;
    }

    _isChecked = widget.isChecked;
  }

  void _toogleJJimKongButton() {
    if (_isChecked == null) return;
    setState(() {
      _isChecked = !_isChecked!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.placeName,
                        style: AppStyles.highlightText,
                      ),
                      SizedBox(width: 4),
                      Text(
                        MapCategory().findCategoryByCode(widget.category),
                        style: AppStyles.defaultText
                            .copyWith(color: AppColor.gray40),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.address,
                    style: AppStyles.subText.copyWith(
                      color: AppColor.gray60,
                    ),
                  ),
                ],
              ),
              if (widget.isReviewable != false)
                JJimKongButton(
                  type: widget.isReviewable == null
                      ? ButtonType.jjimkong
                      : ButtonType.review,
                  isChecked: _isChecked!,
                  onPressed: () async {
                    // 13:00 이후인 경우
                    if (widget.isReviewable != null) {
                      navigateScreen(context,
                          screen: ReviewRegistrationScreen(
                            restaurantId: widget.id,
                            placeName: widget.placeName,
                            address: widget.address,
                          ));
                      return;
                    }

                    // 13:00 이전인 경우
                    await MapService.postPlaceJJimKong(
                        restaurantId: widget.id, isChecked: !_isChecked!);
                    _toogleJJimKongButton();
                  },
                ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            widget.isBottomSheet && widget.description.length > 55
                ? '${widget.description.substring(0, 55)}...'
                : widget.description,
            style: AppStyles.defaultText.copyWith(
              color: AppColor.gray90,
              letterSpacing: 0,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "예상 방문 인원 ${widget.expectedVisitors}명",
            style: AppStyles.subText.copyWith(color: AppColor.gray60),
          ),
        ],
      ),
    );
  }
}
