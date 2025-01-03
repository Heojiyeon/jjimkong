import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/map/models/place_review_model.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/widgets/emoji_reaction_count.dart';

/// 리뷰 목록
///
/// [negativeCount] 부정 반응 수
/// [negativeCount] 긍정 반응 수
class ReviewList extends StatefulWidget {
  final int negativeCount, positiveCount;
  final String placeId;

  const ReviewList({
    super.key,
    required this.placeId,
    required this.negativeCount,
    required this.positiveCount,
  });

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> reviews = [];
  bool _isLoading = false;

  // API 호출 시 사용하는 메서드 (예시)
  Future<void> _fetchReviews() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1), () {});

    setState(() {
      _isLoading = false;
    });
  }

  // 스크롤 끝에 도달했을 때 더 많은 리뷰를 로드
  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchReviews();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "재능인 후기",
                style: AppStyles.highlightText,
              ),
              Row(
                children: [
                  EmojiReactionCount(
                    emojiType: "01",
                    count: widget.positiveCount,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  EmojiReactionCount(
                    emojiType: "02",
                    count: widget.negativeCount,
                  ),
                ],
              ),
            ],
          ),
        ),

        // 리뷰 리스트 컨테이너
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: FutureBuilder<List<PlaceReviewModel>>(
            future: MapService.getReviews(restaurantId: widget.placeId),
            builder: (context, snapshot) {
              // 데이터가 비어있을 때
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return _buildEmptyReview();
              }

              // 리뷰 목록을 표시
              var reviews = snapshot.data!;
              return _buildReviewList(reviews);
            },
          ),
        ),
      ],
    );
  }

  // 리뷰 목록이 없을 때 화면을 그리는 메서드
  Widget _buildEmptyReview() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Text(
          "아직 등록된 후기가 없어요.",
          textAlign: TextAlign.center,
          style: AppStyles.defaultText.copyWith(
            color: AppColor.gray60,
          ),
        ),
      ),
    );
  }

  // 리뷰 목록을 그리는 메서드
  Widget _buildReviewList(List<PlaceReviewModel> reviews) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Review(
          review: review,
          isLastReview: index == reviews.length - 1,
        );
      },
    );
  }
}

/// 리뷰 아이템 위젯
///
/// [review] 리뷰 객체
/// [isLastReview] 마지막 리뷰인지 여부
class Review extends StatelessWidget {
  const Review({
    super.key,
    required this.review,
    required this.isLastReview,
  });

  final PlaceReviewModel review;
  final bool isLastReview;

  String formatDate(String dateTimeString) {
    // review.createdAt을 DateTime 객체로 변환
    DateTime dateTime = DateTime.parse(dateTimeString);

    // 오늘 날짜와 비교
    DateTime now = DateTime.now();

    // 오늘 날짜인지 확인
    bool isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    // 오늘 날짜라면 상대적인 시간 출력
    if (isToday) {
      Duration difference = now.difference(dateTime);
      if (difference.inMinutes < 1) {
        return '방금 전';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}분 전';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}시간 전';
      }
    }

    // 오늘이 아닌 경우는 'MM/dd HH:mm' 포맷 (24시간 형식)
    return DateFormat('MM/dd HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: isLastReview
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColor.gray10,
                  ),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SVGIcon(
                      svgName: review.isPositiveReview
                          ? "ic-emoji-smile"
                          : "ic-emoji-bad",
                      iconSize: IconSize.medium,
                      color: review.isPositiveReview
                          ? AppColor.primary
                          : AppColor.secondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      review.nickName!,
                      style: AppStyles.subText.copyWith(color: AppColor.gray60),
                    ),
                  ],
                ),
                Text(
                  formatDate(review.createdAt!),
                  style: AppStyles.subText
                      .copyWith(fontSize: 10, color: AppColor.gray40),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              review.reviewContent,
              style: AppStyles.defaultText.copyWith(
                letterSpacing: 0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
