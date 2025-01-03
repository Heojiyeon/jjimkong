import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/button.dart';
import 'package:jjimkong/common/widget/carousel_slider.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

///
/// 찜콩 컨텐츠 위젯 컴포넌트
///
///
class JjimkongContent extends StatefulWidget {
  const JjimkongContent({
    super.key,
    required this.menuDatas,
    required this.setJJimedData,
  });

  final List<dynamic> menuDatas;
  final void Function(int) setJJimedData;

  @override
  createState() => _JjimkongContentState();
}

class _JjimkongContentState extends State<JjimkongContent> {
  late List<dynamic> currentMenuDatas;
  late String todayDateString;

  int targetMenuDataIndex = 0;
  late List<dynamic> jjimData = [];

  @override
  void initState() {
    super.initState();

    currentMenuDatas = widget.menuDatas;
  }

  void getTargetMenuDataIndex(int currentMenuDataIndex) {
    setState(() {
      targetMenuDataIndex = currentMenuDataIndex;
    });
  }

  // 찜콩하기 버튼 클릭 시 해당 값 변화
  void setMenuEaten() {
    setState(() {
      currentMenuDatas = currentMenuDatas
          .asMap()
          .map((idx, menuData) {
            if (idx == targetMenuDataIndex) {
              return MapEntry(
                  idx, {...menuData, 'isChecked': !menuData['isChecked']});
            }
            return MapEntry(idx, menuData);
          })
          .values
          .toList();
    });

    widget.setJJimedData(targetMenuDataIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: CarouselSliderWidget(
        menuData: currentMenuDatas,
        targetMenuDataIndex: targetMenuDataIndex,
        getTargetMenuDataIndex: getTargetMenuDataIndex,
        onPressBottomButton: () => widget.setJJimedData,
        isJJimedScreen: true,
        bottomButton: Button(
          sizeState: ButtonSize.icon,
          borderState: ButtonBorder.rounded,
          onPressed: setMenuEaten,
          buttonState: ButtonState.active,
          backgroundColorState:
              currentMenuDatas[targetMenuDataIndex]['isChecked'] as bool
                  ? ButtonBGType.primary10
                  : ButtonBGType.disabled,
          icon: SVGIcon(
            svgName: 'ic-jjimkong',
            iconSize: IconSize.medium,
            color: currentMenuDatas[targetMenuDataIndex]['isChecked'] as bool
                ? AppColor.primary
                : AppColor.secondary60,
          ),
        ),
      ))
    ] //
        );
  }
}
