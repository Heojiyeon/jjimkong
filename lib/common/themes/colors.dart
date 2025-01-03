import 'package:flutter/material.dart';

class AppColor {
  /// 본문 텍스트 색상
  /// 기본 텍스트에 사용
  static const Color dark = Color(0xFF12131A);

  /// 회색 계열 색상
  /// 텍스트, 구분선, 배경 등에 사용
  static const Color gray105 = Color(0xFF0B0B0F);
  static const Color gray90 = Color(0xFF252833);
  static const Color gray80 = Color(0xFF3A3D4D);
  static const Color gray60 = Color(0xFF696C80);
  static const Color gray40 = Color(0xFF9A9EB2);
  static const Color gray30 = Color(0xFFBABDCC);
  static const Color gray20 = Color(0xFFD8DAE5);
  static const Color gray10 = Color(0xFFEBECF2);
  static const Color gray05 = Color(0xFFF4F5FA);

  /// 애플리케이션 주 색상
  /// 강조 텍스트, 버튼 배경 등에 사용
  static const Color primary = Color(0xFFDE114F);
  static const Color primary80 = Color(0xFFE54072);
  static const Color primary60 = Color(0xFFEB7095);
  static const Color primary40 = Color(0xFFF2A0B8);
  static const Color primary20 = Color(0xFFF8CFDC);
  static const Color primary10 = Color(0xFFFCE7E7);

  /// 애플리케이션 보조 색상
  /// 버튼 배경색, 팝업 버튼, 라디오 버튼 등에 사용
  static const Color secondary = Color(0xFF00224D);
  static const Color secondary80 = Color(0xFF334E71);
  static const Color secondary60 = Color(0xFF667A94);
  static const Color secondary40 = Color(0xFF99A7B8);
  static const Color secondary20 = Color(0xFFCCD3DB);
  static const Color secondary10 = Color(0xFFE5E9ED);

  /// 비활성화된 텍스트 색상
  /// 비활성화된 텍스트나 아이콘에 사용
  static const Color disabledTextColor = Color(0XFFBFBFBF);

  /// 비활성화된 버튼 및 필드 배경 색상
  /// 비활성화된 버튼이나 입력 필드의 배경색에 사용
  static const Color disabledBgColor = Color(0XFFEFEFEF);

  /// 팝업 배경 색상 (반투명 검정색 배경)
  /// 팝업이나 모달의 배경에 사용
  static const Color popupBgColor = Color(0x66000000);

  /// 유효하지 않은 입력을 나타내는 텍스트 색상
  /// 잘못된 입력 필드에 사용
  static const Color inValidTextColor = Color(0xFFFF616D);

  /// 유효한 입력을 나타내는 텍스트 색상
  /// 올바른 입력 필드에 사용
  static const Color validTextColor = Color(0xFF29CC6A);

  /// 후기 배경 텍스트 색상
  /// 리뷰 섹션 배경 색상에 사용
  static const Color reviewBgColor = Color(0xFFF8F9FF);

  /// 알림 - 외식 후기 색상
  /// 아이콘 및 텍스트 색상에 사용
  static const Color alarmReviewColor = Color(0xFF12131A);
  static const Color alarmReviewBgColor = Color(0xFFFAFAFA);

  /// 알림 - 메뉴 색상
  /// 아이콘 및 텍스트 색상에 사용
  static const Color alarmMenuColor = Color(0xFF006FFD);
  static const Color alarmMenuBgColor = Color(0xFFEAF2FF);

  /// 알림 - 공지 색상
  /// 아이콘 및 텍스트 색상에 사용
  static const Color alarmNotificationColor = Color(0xFFFFB37C);
  static const Color alarmNotificationBgColor = Color(0xFFFFF4E4);

  /// 알림 - 경고 색상
  /// 아이콘 및 텍스트 색상에 사용
  static const Color alarmWarningColor = Color(0xFFFF616D);
  static const Color alarmWarningBgColor = Color(0xFFFFE2E5);
}
