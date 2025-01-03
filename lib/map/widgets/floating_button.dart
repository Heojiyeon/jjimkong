import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

/// 맵(외식) 페이지 플로팅 버튼
///
/// [top] 버튼의 상단 위치
/// [icon] 아이콘 이름
/// [text] 버튼에 표시될 텍스트
/// [variant]  버튼 색상
///
class FloatingButton extends StatelessWidget {
  final double top;
  final String icon;
  final String text;
  final Color variant;
  final void Function() onPressed;

  const FloatingButton({
    super.key,
    required this.top,
    required this.icon,
    required this.text,
    required this.variant,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: 0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 13,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SVGIcon(
              svgName: icon,
              iconSize: IconSize.medium,
              color: variant,
            ),
            SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                color: variant,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: "Pretendard",
              ),
            ),
          ],
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
