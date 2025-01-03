import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';

/// 알람 타입 코드
/// gn: 일반 공지 / mn: 메뉴 공지 / rn: 리뷰 공지 / an: 알러지 공지
enum AlarmTypeCode { gn, mn, rn, an }

class AlarmCard extends StatefulWidget {
  const AlarmCard({
    super.key,
    required this.noticeId,
    required this.noticeContent,
    required this.noticeTypeCode,
  });

  final String noticeId;
  final String noticeContent;
  final String noticeTypeCode;

  @override
  createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  // 알림 컨텐츠 관리를 위한 변수
  List<String> totalContent = [];

  // 카드 확장될 때 subTitle 노출 여부
  bool showSubTitle = true;

  // string 타입의 알람 타입 -> enum 타입 변환을 위한 객체
  static const Map<String, AlarmTypeCode> alarmTypesMap = {
    "GN": AlarmTypeCode.gn,
    "MN": AlarmTypeCode.mn,
    "RN": AlarmTypeCode.rn,
    "AN": AlarmTypeCode.an,
  };

  ///
  /// 알러지 타입코드에 따른 알림 타입 별 데이터
  /// [title] 알림 타이틀 텍스트
  /// [backgroundColor] 배경 색
  /// [titleColor] 알림 타이틀 색상
  static const Map<AlarmTypeCode, dynamic> alarmTypes = {
    AlarmTypeCode.gn: {
      'title': '공지',
      'backgroundColor': AppColor.alarmNotificationBgColor,
      'titleColor': AppColor.alarmNotificationColor,
    },
    AlarmTypeCode.mn: {
      'title': '오늘의 메뉴',
      'backgroundColor': AppColor.alarmMenuBgColor,
      'titleColor': AppColor.alarmMenuColor,
    },
    AlarmTypeCode.rn: {
      'title': '외식 후기',
      'backgroundColor': AppColor.alarmReviewBgColor,
      'titleColor': AppColor.alarmReviewColor,
    },
    AlarmTypeCode.an: {
      'title': '알러지 경보',
      'backgroundColor': AppColor.alarmWarningBgColor,
      'titleColor': AppColor.alarmWarningColor,
    },
  };

  @override
  void initState() {
    super.initState();

    totalContent = widget.noticeContent.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: alarmTypes[alarmTypesMap[widget.noticeTypeCode]]
          ['backgroundColor'],
      elevation: 0.0,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Padding(
                padding: EdgeInsets.only(
                    right: 4.0, bottom: showSubTitle ? 0.0 : 6.0),
                child: Icon(
                  Icons.error,
                  color: alarmTypes[alarmTypesMap[widget.noticeTypeCode]]
                      ['titleColor'],
                  size: 16.0,
                ),
              ),
              Text(alarmTypes[alarmTypesMap[widget.noticeTypeCode]]['title'],
                  style: AppStyles.defaultText.copyWith(
                    color: alarmTypes[alarmTypesMap[widget.noticeTypeCode]]
                        ['titleColor'],
                    fontWeight: FontWeight.w600,
                  )),
            ]),
            SizedBox(
              height: 6.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...totalContent.map((content) => Text(
                      content,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.subText,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
