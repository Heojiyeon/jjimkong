import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/allergy_code.dart';
import 'package:jjimkong/common/util/open_popup.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/check_box.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/content/screens/content.dart';
import 'package:jjimkong/signin/services/sign_up_service.dart';

class SignUpAllergyScreen extends StatefulWidget {
  const SignUpAllergyScreen({super.key});

  @override
  State<SignUpAllergyScreen> createState() => _SignUpAllergyScreenState();
}

class _SignUpAllergyScreenState extends State<SignUpAllergyScreen> {
  // 알러지 체크 상태를 저장할 리스트
  late List<Map<String, dynamic>> _checkedInfoList = AllergyCode.allergyCodes
      .map(
        (allergy) => {
          'code': allergy['code'],
          'name': allergy['name'],
          'isChecked': false,
        },
      )
      .toList();

  @override
  void initState() {
    super.initState();
  }

  void _onPressedNextButton() {
    final Map<String, dynamic> popupContent = {
      'firstLineContent': '선택된 알러지가 없습니다.',
      'secondLineContent': '진행하시겠습니까?',
    };

    /// 하나라도 선택되었다면
    if (_checkedInfoList.any((infoData) => infoData['isChecked'])) {
      popupContent['firstLineContent'] = '선택한 알러지들을 등록하시겠습니까?';
      popupContent['secondLineContent'] = null;
    }

    openPopup(
      context,
      title: '알러지 등록 확인',
      firstLineContent: popupContent['firstLineContent'],
      secondLineContent: popupContent['secondLineContent'],
      hasCancelButton: true,
      onPressedCheckButton: _registAllergy,
    );
  }

  void _registAllergy() async {
    final List<String> checkedAllergies = _checkedInfoList
        .where((infoData) => infoData['isChecked'])
        .map((infoData) => infoData['code'] as String)
        .toList();

    await SignUpService.postAllergy(checkedAllergies);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Content()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Description(
                title: '보유 중인 알러지에 체크하세요',
                description: '알러지 반응을 일으킬 수 있는 메뉴가 나오는 날\n알림을 보내드릴게요',
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: -4,
                children: _checkedInfoList
                    .map((infoData) => CheckBox(
                          name: infoData['name'],
                          isChecked: infoData['isChecked'],
                          onChange: () {
                            setState(() {
                              infoData['isChecked'] = !infoData['isChecked'];
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '※ 조개류: 굴, 전복, 홍합 포함',
                  style:
                      AppStyles.subText.copyWith(color: AppColor.secondary40),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: '등록',
          onPressed: _onPressedNextButton,
        ));
  }
}
