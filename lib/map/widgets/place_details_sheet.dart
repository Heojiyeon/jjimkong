import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/map/models/place_details_model.dart';
import 'package:jjimkong/map/screens/place_detail_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/utils/fade_navigate.dart';
import 'package:jjimkong/map/widgets/emoji_reaction_chart.dart';
import 'package:jjimkong/map/widgets/place_detail_item.dart';

/// 지도 바텀시트 위젯
///
/// [restaurantId] 장소 아이디
class PlaceDetailsSheet extends StatefulWidget {
  final String restaurantId; // restaurantId를 파라미터로 받음
  const PlaceDetailsSheet({super.key, required this.restaurantId});

  @override
  State<PlaceDetailsSheet> createState() => _PlaceDetailsSheetState();
}

class _PlaceDetailsSheetState extends State<PlaceDetailsSheet>
    with TickerProviderStateMixin {
  bool _isExpanded = false; // 바텀시트 열림 여부
  late AnimationController _animationController;
  late Animation<double> _animation;

  double _currentChildSize = 0.4; // 초기 바텀시트 크기 지정

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 120),
      vsync: this,
    );

    // 초기 애니메이션 설정
    _animation = Tween<double>(begin: _currentChildSize, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleSheet() {
    setState(() {
      if (_isExpanded) {
        _animation =
            Tween<double>(begin: _animationController.value, end: 0.4).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
      } else {
        _animation =
            Tween<double>(begin: _animationController.value, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
        _isExpanded = true;
      }

      // 애니메이션 시작 후, 페이지 이동
      _animationController.forward(from: 0).then((_) {
        if (_isExpanded) {
          Navigator.push(
            context,
            fadeInPageRoute(PlaceDetailScreen(
              restaurantId: widget.restaurantId,
            )),
          ).then((_) {
            _isExpanded = false;
            _closeSheet();
          });
        }
      });
    });
  }

  // 페이지 이동 후 바텀시트를 축소하는 함수
  void _closeSheet() {
    Future.delayed(Duration(milliseconds: 120), () {
      setState(() {
        _animation =
            Tween<double>(begin: _animationController.value, end: 0.4).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
        _animationController.forward(from: 0);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .12),
                blurRadius: 8,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 120),
              curve: Curves.easeInOut,
              height:
                  MediaQuery.of(context).size.height * _animation.value - 220,
              constraints: BoxConstraints(minHeight: 300),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _toggleSheet,
                      child: const Grabber(),
                    ),
                    FutureBuilder<PlaceDetailsModel>(
                      future: MapService.getPlace(
                          restaurantId: widget.restaurantId),
                      builder: (context, snapshot) {
                        if (snapshot.error != null) {
                          return Text('${snapshot.error}');
                        }
                        // 데이터가 없는 경우
                        if (!snapshot.hasData) {
                          return Text('존재하지 않는 장소입니다. ${widget.restaurantId}');
                        }

                        var placeDetails = snapshot.data!;
                        var place = placeDetails.place;

                        return Flexible(
                          child: Column(
                            children: [
                              PlaceDetailItem(
                                isBottomSheet: true,
                                id: place.restaurantId!,
                                placeName: place.restaurantName,
                                category: place.category,
                                address: place.address,
                                description: place.description,
                                expectedVisitors: place.checkCount ?? 0,
                                isChecked: placeDetails.isChecked,
                                isReviewable: placeDetails.isReviewable,
                              ),
                              SizedBox(
                                  height:
                                      place.description.length > 55 ? 8 : 28),
                              EmojiReactionChart(
                                positiveCount: place.positiveReviewCount ?? 0,
                                negativeCount: place.negativeReviewCount ?? 0,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 바텀시트 터치 영역
class Grabber extends StatelessWidget {
  const Grabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          width: 36.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: AppColor.gray20,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
