import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/home/widget/alarm_card.dart';

///
/// 알림 리스트 스크린
///
class AlarmListScreen extends StatefulWidget {
  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  /// 임시 알림 데이터
  /// TODO: 알림 api 연동 필요
  static const List<Map<String, String>> alarmList = [
    {
      "noticeId": "01JFS9S3RTDW1KSK1REN1R0CYY",
      "noticeContent":
          "안녕하세요, 직원식당에서 알려드립니다.\n오늘 직원식당은 내부 행사로 인해\n11시 30분부터 12시 10분까지만 이용 가능합니다.\n12시 20분부터는 행사로 어려우니, 참고하시기 바랍니다.",
      "noticeTypeCode": "GN"
    },
    {
      "noticeId": "01JFS9S3D7VK4FQ5QKA1SE07EC",
      "noticeContent": "오늘 메뉴가 도착했어요!\n돼지김치찜 / 된장국 / 샐러드 / 로제 떡볶이 / 흑미밥 / 유자차",
      "noticeTypeCode": "MN"
    },
    {
      "noticeId": "01JFS9S3AD5BC63B2MH7SBN92B",
      "noticeContent": "점심 식사 맛있게 하셨나요?\n재능인들을 위해 후기 작성 부탁드려요 :)",
      "noticeTypeCode": "RN"
    },
    {
      "noticeId": "01JFS9S3AD5BC63B2MH7SBN92B",
      "noticeContent": "뉴진슬기님!\n알러지 유발 식품 ‘복숭아’ 포함 주의 경보! 🚨",
      "noticeTypeCode": "AN"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: "알림",
      ),
      body: BaseLayout(
        hasHorizontalPadding: true,
        child: Column(
          children: [
            ...alarmList.map(
              (alarm) => AlarmCard(
                noticeId: alarm['noticeId']!,
                noticeContent: alarm['noticeContent']!,
                noticeTypeCode: alarm['noticeTypeCode']!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
