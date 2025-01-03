// FadeIn 애니메이션을 위한 커스텀 페이지 라우트
import 'package:flutter/material.dart';

PageRouteBuilder fadeInPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
