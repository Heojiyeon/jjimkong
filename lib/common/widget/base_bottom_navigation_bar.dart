import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

class BaseBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BaseBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: const Color(0xFFFAFAFA),
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.gray40,
        selectedLabelStyle: AppStyles.subText,
        unselectedLabelStyle: AppStyles.subText,
        items: _buildBottomNavigationBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    const itemsData = [
      {'svgName': 'ic-home', 'label': '홈'},
      {'svgName': 'ic-eat', 'label': '외식'},
      {'svgName': 'ic-board', 'label': '제안'},
    ];

    return itemsData.map((item) {
      return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SVGIcon(
            svgName: item['svgName']!,
            iconSize: IconSize.medium,
            color: AppColor.gray40,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SVGIcon(
            svgName: item['svgName']!,
            iconSize: IconSize.medium,
            color: AppColor.primary,
          ),
        ),
        label: item['label']!,
      );
    }).toList();
  }
}
