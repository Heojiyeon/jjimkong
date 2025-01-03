import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 체크 박스 위젯
/// 체크 박스 선택 유무에 따라 색깔을 다르게 보여준다.
///
/// [name]은 체크 박스 라벨 이름
/// [isChecked]는 체크 박스 선택 유무를 나타내는 값
/// [onChange]는 체크 박스의 선택 유무 변경
///

class CheckBox extends StatelessWidget {
  final String name;
  final bool isChecked;
  final void Function() onChange;

  const CheckBox({
    super.key,
    required this.name,
    required this.isChecked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        minimumSize: Size.zero, // 최소 크기 제거
        backgroundColor: isChecked ? AppColor.primary : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          side: BorderSide(
            color: AppColor.gray20,
            width: isChecked ? 0 : 1,
          ),
        ),
      ),
      onPressed: onChange,
      child: Text(
        name,
        style: AppStyles.defaultText.copyWith(
            height: 1,
            fontWeight: FontWeight.w500,
            color: isChecked ? Colors.white : AppColor.dark),
      ),
    );
  }
}

/// 위젯북 - 체크된 체크박스
@widgetbook.UseCase(name: "Checked", type: CheckBox)
Widget checkedBox(BuildContext centext) {
  return Center(
    child: CheckBox(name: '우유', isChecked: true, onChange: () {}),
  );
}

/// 위젯북 - 체크 해제된 체크박스
@widgetbook.UseCase(name: "UnChecked", type: CheckBox)
Widget unCheckedBox(BuildContext centext) {
  return Center(
    child: CheckBox(name: '우유', isChecked: false, onChange: () {}),
  );
}
