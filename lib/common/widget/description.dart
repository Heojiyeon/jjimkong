import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

/// 디스크립션 위젯
/// 페이지의 타이틀과 디스크립션을 만드는 컴포넌트입니다.
///
/// [appbar]는 appbar의 유무, 기본 값은 false
/// [title]은 타이틀 메시지
/// [description]는 설명 메시지
class Description extends StatelessWidget {
  final String title;
  final String description;
  final bool appbar;

  const Description({
    super.key,
    this.appbar = false,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: appbar ? 36 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.pageTitle.copyWith(
              letterSpacing: 0,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: AppStyles.defaultText.copyWith(
              color: AppColor.gray40,
              letterSpacing: 0,
              height: 1.2,
            ),
          )
        ],
      ),
    );
  }
}

@UseCase(name: "Description", type: Description)
Widget description(BuildContext context) {
  return Center(
    child: Description(
      title: "타이틀 입력 영역",
      description: "설명 텍스트를 작성합니다.",
    ),
  );
}
