import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

/// 화면 너비 전체를 차지하는 하단 버튼.
/// Scaffold의 bottomNavigationBar에 사용된다.
///
/// [text] : 버튼에 표시될 텍스트
/// [onPressed] : 버튼이 눌렸을 때 실행될 콜백함수
/// [isDisabled] : (optional) 버튼의 활성화 여부를 나타내는 플래그
class BottomButton extends StatelessWidget {
  final String text; // 버튼에 표시될 텍스트
  final VoidCallback onPressed; // 버튼이 눌렸을 때 실행될 콜백함수
  final bool isDisabled; // 버튼의 활성화 여부를 나타내는 플래그

  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColors = {
      'background': isDisabled ? AppColor.disabledBgColor : AppColor.primary,
      'foreground': isDisabled ? AppColor.disabledTextColor : Colors.white,
    };

    /// 버튼 스타일
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize:
          Size(MediaQuery.of(context).size.width, kBottomNavigationBarHeight),
      backgroundColor: buttonColors['background'],
      disabledBackgroundColor: buttonColors['background'],
      disabledForegroundColor: buttonColors['foreground'],
      elevation: 0,
      shadowColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );

    return Container(
      color: buttonColors['background'],
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: kBottomNavigationBarHeight,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ? null : onPressed,
          child: Text(
            text,
            style: AppStyles.highlightText
                .copyWith(color: buttonColors['foreground']),
          ),
        ),
      ),
    );
  }
}

/// 위젯북 유즈케이스 정의
/// 기본 바텀 버튼
@UseCase(name: "Default", type: BottomButton)
Widget defaultBottomButton(BuildContext context) {
  return Center(
    child: BottomButton(
      text: "등록",
      onPressed: () {},
    ),
  );
}

/// 비활성화된 바텀 버튼
@UseCase(name: "Disabled", type: BottomButton)
Widget disabledBottomButton(BuildContext context) {
  return Center(
    child: BottomButton(
      text: "등록",
      onPressed: () {},
      isDisabled: true,
    ),
  );
}
