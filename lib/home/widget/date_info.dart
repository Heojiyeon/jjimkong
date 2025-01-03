import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/home/util/date_formatter.dart';

///
/// 날짜 정보 컴포넌트
/// [isJJimed] 찜콩 여부
/// [currentDate] 현재 날짜 정보 / 예) 2024-12-23
///
///
class DateInfo extends StatelessWidget {
  const DateInfo({super.key, this.isJJimed, required this.currentDate});

  final bool? isJJimed;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().toString();
    var date = dateFormmater(currentDate);

    return SizedBox(
      width: double.infinity,
      child: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isJJimed != null)
                SVGIcon(
                  svgName: 'ic-jjimkong',
                  iconSize: IconSize.small,
                  color: AppColor.primary,
                ),
              Text(
                  dateFormmater(today) == date
                      ? '오늘'
                      : '${getWeekday(currentDate)}요일',
                  style: AppStyles.highlightText),
            ],
          ),
          Text(
            date,
            style: AppStyles.defaultText,
          )
        ],
      )),
    );
  }
}
