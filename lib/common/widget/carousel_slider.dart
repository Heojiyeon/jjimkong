import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jjimkong/home/widget/date_info.dart';
import 'package:jjimkong/home/widget/menu_card.dart';

///
/// 케러셀 슬라이드 컴포넌트
/// [menuData] 메뉴 데이터
/// [targetMenuDataIndex] 현재 화면에 보여줄 데이터 인덱스
/// [getTargetMenuDataIndex] 슬라이드 시 현재 화면에 보여지는 데이터 인덱스 핸들링 함수
/// [bottomButton] 케러셀 슬라이드 하단 버튼 위젯
/// [onPressBottomButton] 하단 버튼 클릭 시 핸들링 함수
/// [isJJimedScreen] 찜콩 화면 여부
///
///
class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    super.key,
    required this.menuData,
    required this.targetMenuDataIndex,
    required this.getTargetMenuDataIndex,
    required this.bottomButton,
    required this.onPressBottomButton,
    this.isJJimedScreen,
  });

  final List<dynamic> menuData;
  final int targetMenuDataIndex;
  final void Function(int) getTargetMenuDataIndex;
  final Widget bottomButton;
  final VoidCallback onPressBottomButton;
  final bool? isJJimedScreen;

  @override
  createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSliderWidget> {
  late String todayDateString;
  late List<dynamic> menuContentDatas;
  late int todayIndex;

  // TODO: 추후 실제 api 데이터 연동 예정
  @override
  void initState() {
    super.initState();
    todayDateString = widget.menuData[widget.targetMenuDataIndex]['menuDate'];

    menuContentDatas = widget.menuData;
    todayIndex = widget.targetMenuDataIndex;
  }

  /// 슬라이드 시 날짜 데이터 업데이트 함수
  /// todayIndex에 해당하는 menuDate를 활용해 오늘 날짜 데이터 생성
  void setTodayDateString() {
    var targetMenuData = widget.menuData[todayIndex];
    DateTime parsedDate = DateTime.parse(targetMenuData['menuDate']);

    setState(() {
      todayDateString = parsedDate.toIso8601String().split('T')[0];
    });
  }

  // 먹었어요 버튼 클릭 시 해당 값 변화
  void setMenuEaten() {
    setState(() {
      menuContentDatas = menuContentDatas
          .asMap()
          .map((idx, menuData) {
            if (idx == widget.targetMenuDataIndex) {
              return MapEntry(
                  idx, {...menuData, 'isMenuEaten': !menuData['isMenuEaten']});
            }
            return MapEntry(idx, menuData);
          })
          .values
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: menuContentDatas
          .map<Widget>(
            (data) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // date info area
                    DateInfo(
                      isJJimed: data['isJJimed'],
                      currentDate: todayDateString,
                    ),
                    MenuCard(
                      menuData: data['dishes'],
                      isJJimedScreen: widget.isJJimedScreen,
                      isTargetMenu: data['menuId'] ==
                              widget.menuData[todayIndex]['menuId']
                          ? true
                          : false,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 34,
                      child: Center(child: widget.bottomButton),
                    )
                  ],
                ),
              ],
            ),
          )
          .toList(),
      options: CarouselOptions(
        aspectRatio: widget.isJJimedScreen != null
            ? 6 / 9
            : 6 / 9.1, // 원하는 비율을 지정 (16:9 비율 예시)
        autoPlay: false, // 자동 슬라이드 끄기
        viewportFraction:
            widget.isJJimedScreen != null ? 0.75 : 0.7, // 각 페이지가 차지하는 화면 비율
        enlargeCenterPage: true, // 중앙 페이지 확대
        initialPage: todayIndex, // 첫 페이지 설정
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            todayIndex = index; // 페이지 변경 시 activeIndex 갱신
            setTodayDateString();

            widget.getTargetMenuDataIndex(index);
          });
        },
      ),
    );
  }
}
