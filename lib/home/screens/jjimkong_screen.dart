import 'package:flutter/material.dart';
import 'package:jjimkong/common/util/navigate_screen.dart';
import 'package:jjimkong/common/util/open_popup.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/home/models/menu_check_model.dart';
import 'package:jjimkong/home/services/home_service.dart';
import 'package:jjimkong/home/widget/jjimkong_content.dart';

class JJimkongScreen extends StatefulWidget {
  @override
  State<JJimkongScreen> createState() => _JJimkongScreenState();
}

class _JJimkongScreenState extends State<JJimkongScreen> {
  late List<dynamic> currentMenuDatas;
  late List<dynamic> jjimData = [];

  @override
  void initState() {
    super.initState();
  }

// 등록 버튼 클릭 시 핸들링 함수
  void setJJimedData(int targetMenuDataIndex) async {
    setState(() {
      // var targetJJimedData = currentMenuDatas[targetMenuDataIndex];

      // var isJJimData = jjimData.firstWhere(
      //   (data) => data['menuId'] == targetJJimedData['menuId'],
      //   orElse: () => {}, // 조건에 맞는 항목이 없을 때 null 반환
      // );

      // 현재 메뉴 데이터의 상태 업데이트
      currentMenuDatas = currentMenuDatas
          .asMap()
          .map((idx, menuData) {
            if (idx == targetMenuDataIndex) {
              return MapEntry(
                  idx, {...menuData, 'isChecked': menuData['isChecked']});
            }
            return MapEntry(idx, menuData);
          })
          .values
          .toList();

      jjimData = jjimData
          .asMap()
          .map((idx, menuData) {
            if (idx == targetMenuDataIndex) {
              return MapEntry(
                  idx, {...menuData, 'isChecked': !menuData['isChecked']});
            }
            return MapEntry(idx, menuData);
          })
          .values
          .toList();
    });
  }

  void _onPressButton() async {
    for (var data in jjimData) {
      MenuCheckModel menuCheck = MenuCheckModel(
        menuId: data['menuId'],
        isChecked: data['isChecked'],
      );
      await HomeService.postMenuCheck(
        menuId: menuCheck.menuId,
        isChecked: menuCheck.isChecked,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: "메뉴 찜콩",
      ),
      body: BaseLayout(
        hasHorizontalPadding: false,
        hasTopPadding: false,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Description(
                    appbar: true,
                    title: '우리... 찜콩할래요?',
                    description: '찜콩 데이터는 잔반 줄이기에 도움돼요.'),
              ),
            ),
            SizedBox(height: 36),
            FutureBuilder<List<dynamic>>(
              future: HomeService.getMenuInfoNext(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: 10,
                  );
                } else {
                  currentMenuDatas = snapshot.data!;
                  if (jjimData.isEmpty) {
                    jjimData = currentMenuDatas
                        .asMap()
                        .map((idx, menuData) {
                          return MapEntry(idx, {
                            'menuId': menuData['menuId'],
                            'isChecked': menuData['isChecked']
                          });
                        })
                        .values
                        .toList();
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: screenHeight - 360,
                    child: JjimkongContent(
                      menuDatas: snapshot.data!,
                      setJJimedData: setJJimedData,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        text: '등록',
        onPressed: () {
          _onPressButton();
          openPopup(context, title: '메뉴 찜콩', firstLineContent: '찜콩을 완료했습니다.',
              onPressedCheckButton: () async {
            navigateToBeforeScreen(context);
          });
        },
        isDisabled: jjimData.isEmpty ? true : false,
      ),
    );
  }
}
