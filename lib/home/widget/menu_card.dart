import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/allergy_code.dart';

///
/// 메뉴 카드 컴포넌트
///
/// [menuData] 해당 날짜 메뉴 정보
///
///
class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menuData,
    required this.isTargetMenu,
    this.isJJimedScreen,
  });

  final List<dynamic> menuData;
  final bool isTargetMenu;
  final bool? isJJimedScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0, bottom: 10.0),
      child: SizedBox(
        width: 276,
        height: 392,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
          curve: Curves.easeInOut, // 애니메이션 커브
          decoration: BoxDecoration(
            color: isTargetMenu ? Colors.white : AppColor.gray10,
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06), // 그림자 색상
                spreadRadius: 2, // 그림자 확산 반경
                blurRadius: 20, // 그림자 흐림 반경
                offset: Offset(0, 2), // 그림자 위치 (x, y)
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: isJJimedScreen != null ? 0.0 : 28.0,
                horizontal: 34.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...menuData.map(
                  (data) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['dishName'],
                              style: AppStyles.defaultText,
                            ),
                            if (data['allergyWarning'].isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: AppColor.primary,
                                    size: 14.0,
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 4.0)),
                                  ...data['allergyWarning'].map((allergyData) {
                                    return Text(
                                      '${AllergyCode.getAllergyNameByCode(allergyData)} ',
                                      style: AppStyles.subText.copyWith(
                                        color: AppColor.primary,
                                      ),
                                    );
                                  })
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(right: 4.0, top: 14)),
                                  ...data['allergyWarning'].map((allergyData) {
                                    return Text('');
                                  })
                                ],
                              )
                          ],
                        ),
                        Text(
                          data['calories'] != null
                              ? '${data['calories']}kcal'
                              : '-',
                          style: AppStyles.subText
                              .copyWith(color: AppColor.gray40),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
