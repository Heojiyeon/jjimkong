import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/open_popup.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/common/widget/input_field.dart';
import 'package:jjimkong/map/models/place_review_model.dart';
import 'package:jjimkong/map/screens/place_detail_screen.dart';
import 'package:jjimkong/map/screens/place_registration_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/widgets/review_button.dart';

/// 리뷰 등록하는 페이지
///
/// 방문 리뷰를 작성한다.
/// [restaurantId] 레스토랑 아이디
/// [placeName] 장소명
/// [address] 주소
///
class ReviewRegistrationScreen extends StatefulWidget {
  final String restaurantId;
  final String placeName;
  final String address;

  const ReviewRegistrationScreen({
    super.key,
    required this.restaurantId,
    required this.placeName,
    required this.address,
  });

  @override
  _ReviewRegistrationScreenState createState() =>
      _ReviewRegistrationScreenState();
}

class _ReviewRegistrationScreenState extends State<ReviewRegistrationScreen> {
  TextEditingController _reviewTextController = TextEditingController();
  String isPositiveReview = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setIsPositiveReview(String value) {
    setState(() {
      if (value == isPositiveReview) {
        isPositiveReview = '';
      } else {
        isPositiveReview = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BaseAppBar(
          title: "후기 작성",
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "map_next_button",
        child: BottomButton(
          isDisabled: isPositiveReview == '',
          onPressed: () async {
            PlaceReviewModel placeReview = PlaceReviewModel(
              restaurantId: widget.restaurantId,
              reviewContent: _reviewTextController.text,
              isPositiveReview: isPositiveReview == 'positive',
            );
            await MapService.postReview(placeReview);

            if (mounted) {
              openPopup(context,
                  title: '후기 등록',
                  firstLineContent: '성공적으로 등록되었습니다.', onPressedCheckButton: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(
                      restaurantId: widget.restaurantId,
                    ),
                  ),
                );
              });
            }
          },
          text: "등록",
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: BaseLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Description(
                appbar: true,
                title: '식사 맛있게 하셨나요?',
                description: '찜콩에 후기를 공유해주세요',
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColor.gray05,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 66, vertical: 14),
                  child: Column(
                    children: [
                      Text(
                        widget.placeName,
                        style: AppStyles.subTitle.copyWith(
                          color: AppColor.gray80,
                          height: 1.1875,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.address,
                        style: AppStyles.defaultText.copyWith(
                          color: AppColor.gray60,
                          height: 1.214,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Row(children: [
                  ReviewButton(
                    title: 'positive',
                    isPositiveReview: isPositiveReview,
                    setIsPositiveReview: setIsPositiveReview,
                  ),
                  SizedBox(width: 16),
                  ReviewButton(
                    title: 'negative',
                    isPositiveReview: isPositiveReview,
                    setIsPositiveReview: setIsPositiveReview,
                  ),
                ]),
              ),
              Column(
                children: [
                  SizedBox(height: 36),
                  FormLabel(labelName: '어떤 점이 만족스러웠나요?'),
                  InputField(
                    placeholder: '재능인에게 도움이 되는 생생한 후기를 남겨주세요.',
                    limitLength: 200,
                    controller: _reviewTextController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
