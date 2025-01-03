import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/button.dart';
import 'package:jjimkong/common/widget/carousel_slider.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/home/models/eaten_model.dart';
import 'package:jjimkong/home/services/home_service.dart';

class ButtonStyles {
  static Map<String, dynamic> getStyles(
      bool isMenuEatenDisabled, bool isMenuEaten) {
    return {
      "textColor": isMenuEatenDisabled
          ? ButtonTextType.disabled
          : isMenuEaten
              ? ButtonTextType.primary
              : ButtonTextType.secondary,
      "backgroundColor": isMenuEatenDisabled
          ? ButtonBGType.disabled
          : isMenuEaten
              ? ButtonBGType.primary10
              : ButtonBGType.secondary10,
      "iconColor": isMenuEatenDisabled
          ? AppColor.disabledTextColor
          : isMenuEaten
              ? AppColor.primary
              : AppColor.secondary,
    };
  }
}

///
/// 메뉴 메인 컨텐츠 위젯 컴포넌트
///
///
///
class MenuContent extends StatefulWidget {
  const MenuContent({
    super.key,
    required this.menuDatas,
  });

  final List<dynamic> menuDatas;

  @override
  createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  late String todayDateString;
  late int targetMenuDataIndex = 0;
  late List<dynamic> currentMenuDatas;

  @override
  void initState() {
    super.initState();

    currentMenuDatas = widget.menuDatas.cast<dynamic>();

    // 전체 메뉴 데이터 중 오늘 날짜의 데이터 필터링
    // 오늘 날짜 데이터 인덱스 초기화
    todayDateString = DateTime.now().toIso8601String().split('T')[0];
    targetMenuDataIndex = 1;
  }

  void getTargetMenuDataIndex(int currentMenuDataIndex) {
    setState(() {
      targetMenuDataIndex = currentMenuDataIndex;
    });
  }

  // 먹었어요 버튼 클릭 시 해당 값 변화
  void setMenuEaten() async {
    if (currentMenuDatas[targetMenuDataIndex]['isMenuEatenDisabled']) return;
    setState(() {
      currentMenuDatas = currentMenuDatas
          .asMap()
          .map((idx, menuData) {
            if (idx == targetMenuDataIndex) {
              return MapEntry(
                  idx, {...menuData, 'isMenuEaten': !menuData['isMenuEaten']});
            }
            return MapEntry(idx, menuData);
          })
          .values
          .toList();
    });

    MenuEatenModel menuEaten = MenuEatenModel(
      menuId: currentMenuDatas[targetMenuDataIndex]['menuId'],
      isMenuEaten: currentMenuDatas[targetMenuDataIndex]['isMenuEaten'],
    );

    await HomeService.postMenuEaten(
      menuId: menuEaten.menuId,
      isMenuEaten: menuEaten.isMenuEaten,
    );
  }

  @override
  Widget build(BuildContext context) {
    var style = ButtonStyles.getStyles(
        currentMenuDatas[targetMenuDataIndex]['isMenuEatenDisabled'],
        currentMenuDatas[targetMenuDataIndex]['isMenuEaten']);

    return CarouselSliderWidget(
      menuData: currentMenuDatas,
      targetMenuDataIndex: targetMenuDataIndex,
      getTargetMenuDataIndex: getTargetMenuDataIndex,
      onPressBottomButton: setMenuEaten,
      bottomButton: SizedBox(
        width: double.infinity,
        height: 34,
        child: Center(
          child: Button(
            onPressed: setMenuEaten,
            text: '먹었어요',
            textColorState: style['textColor'],
            buttonState: ButtonState.active,
            backgroundColorState: style['backgroundColor'],
            sizeState: ButtonSize.medium,
            icon: SVGIcon(
              svgName: 'ic-delicious',
              iconSize: IconSize.small,
              color: style['iconColor'],
            ),
          ),
        ),
      ),
    );
  }
}
