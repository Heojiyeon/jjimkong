import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';

// 라디오버튼 위젯
// 카테고리 리스트와 현재 선택된 값을 내려주면 일치하는 UI를 반환한다.
///
/// [values] 카테고리 리스트
/// [selectedValue] 현재 선택된 값
/// [onChange] 라디오버튼 클릭 시 실행될 함수

class RadioButton extends StatefulWidget {
  final List<String> values;
  final String selectedValue;
  final void Function(String value) onChange;

  const RadioButton({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.onChange,
  });

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelected(int index) {
    // 버튼의 너비(가로 크기)를 예측합니다. 버튼 크기 및 간격에 맞게 수정하세요.
    double buttonWidth = 80.0; // 버튼의 너비
    double padding = 10.0; // 버튼 사이의 간격
    double itemWidth = buttonWidth + padding; // 한 항목의 전체 너비

    // 각 버튼의 위치 계산
    double targetOffset = index * itemWidth;

    // 화면의 중앙을 맞추기 위해 targetOffset을 이동
    double screenWidth = MediaQuery.of(context).size.width;
    double centerOffset = targetOffset - (screenWidth / 2) + (buttonWidth / 2);

    // 화면의 양 끝을 벗어나지 않도록 범위 제한
    double maxOffset = _scrollController.position.maxScrollExtent;
    double minOffset = _scrollController.position.minScrollExtent;

    if (centerOffset < minOffset) {
      centerOffset = minOffset;
    } else if (centerOffset > maxOffset) {
      centerOffset = maxOffset;
    }

    // 애니메이션으로 스크롤
    _scrollController.animateTo(
      centerOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController, // ScrollController 추가
      padding: EdgeInsets.only(left: 14),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(widget.values.length, (int index) {
          var selected = widget.selectedValue == widget.values[index];
          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              height: 34,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: selected ? AppColor.secondary : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    side: BorderSide(
                      color: AppColor.gray20,
                      width: selected ? 0 : 1,
                    ),
                  ),
                ),
                onPressed: () {
                  widget.onChange(widget.values[index]);
                  _scrollToSelected(index); // 선택된 버튼으로 스크롤
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    widget.values[index],
                    style: AppStyles.defaultText.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : AppColor.gray40,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
