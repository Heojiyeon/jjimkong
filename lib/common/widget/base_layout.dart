import 'package:flutter/material.dart';

/// padding을 적용한 SafeArea 위젯.
/// 기본 패딩이 적용된 SafeArea 위젯으로 hasTopPadding, hasHorizontalPadding 옵션을 통해 패딩 제거가 가능하다.
///
/// [hasTopPadding]이 false일 경우, top padding을 제거
/// [hasHorizontalPadding]이 false일 경우, left, right padding을 제거
class BaseLayout extends StatelessWidget {
  final bool hasTopPadding; // optional: 전체 화면 여부를 결정 - 기본값 true
  final bool hasHorizontalPadding; // optional: 전체 화면 여부를 결정 - 기본값 true
  final Widget child; // required: 자식 위젯

  const BaseLayout({
    super.key,
    this.hasTopPadding = true,
    this.hasHorizontalPadding = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: hasHorizontalPadding ? 14 : 0,
          right: hasHorizontalPadding ? 14 : 0,
          top: hasTopPadding ? 20 : 0,
        ),
        child: child,
      ),
    );
  }
}
