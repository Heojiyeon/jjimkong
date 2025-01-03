import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';

class AppStyles {
  /// 페이지 타이틀 스타일
  static const TextStyle pageTitle = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.dark,
  );

  /// 서브 타이틀 스타일
  static const TextStyle subTitle = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.dark,
  );

  /// 강조 텍스트 스타일
  static const TextStyle highlightText = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColor.dark,
  );

  /// 기본 텍스트 스타일
  static const TextStyle defaultText = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.dark,
  );

  /// 설명 텍스트 스타일
  static const TextStyle subText = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColor.dark,
  );
}
