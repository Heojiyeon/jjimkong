import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/home/screens/jjimkong_screen.dart';
import 'package:jjimkong/home/services/home_service.dart';
import 'package:jjimkong/home/widget/menu_content.dart';
import 'package:jjimkong/home/widget/top_bar.dart';

class MenuItem {
  final String menuId;
  final String menuDate;
  final List<dynamic> dishes;

  MenuItem({
    required this.menuId,
    required this.menuDate,
    required this.dishes,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      menuId: json['menuId'] as String,
      menuDate: json['menuDate'] as String,
      dishes: json['dishes'] as List<Map<String, dynamic>>,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isShowJJimkongButton = false;

  @override
  void initState() {
    super.initState();
    isShowJJimkongButton = true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BaseLayout(
      hasHorizontalPadding: false,
      hasTopPadding: false,
      child: Scaffold(
        body: Column(
          children: [
            // Top bar area
            Topbar(),
            // Content area
            Expanded(
              child: Center(
                // child: Text('하이'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: HomeService.getMenuInfoWeekly(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text('');
                      return MenuContent(
                        menuDatas: snapshot.data!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: isShowJJimkongButton
            ? FloatingActionButton.extended(
                onPressed: () {
                  navigateScreen(context, screen: JJimkongScreen());
                },
                backgroundColor: AppColor.gray05,
                icon: SVGIcon(
                  svgName: 'ic-jjimkong',
                  iconSize: IconSize.xlarge,
                  color: AppColor.primary,
                ),
                elevation: 0.0,
                focusElevation: 0.0,
                label: SizedBox(
                  width: screenWidth - 90,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '이번 주도 끝나가요',
                              style: AppStyles.subText
                                  .copyWith(color: AppColor.gray40),
                            ),
                            Text('다음 주 메뉴 찜콩하기', style: AppStyles.defaultText)
                          ],
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.gray40,
                          size: 24.0,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
