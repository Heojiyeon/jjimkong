import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/common/util/sign_out.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/home/screens/alarm_list_screen.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});

  @override
  createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  // TODO: 알람 존재 여부에 따른 상태 값 핸들링 함수 구현 예정
  bool hasAlarm = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  signOut();
                },
                child: SvgPicture.asset(
                  'assets/images/ic-logo-primary.svg', // SVG 경로
                  height: 38,
                )),
            IconButton(
                onPressed: () {
                  navigateScreen(context, screen: AlarmListScreen());
                },
                icon: SVGIcon(
                  svgName: hasAlarm ? 'ic-bell-active' : 'ic-bell',
                  iconSize: IconSize.xlarge,
                )),
          ],
        ),
      ),
    );
  }
}
