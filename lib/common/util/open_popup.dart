import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';

///
/// 팝업 유틸 함수
///
/// [context] 현재 실행하고자 하는 위젯 위치 식별자
/// [title] 팝업 제목
/// [firstLineContent] 팝업 내용 첫번째 줄
/// [secondLineContent] 팝업 내용 두번째 줄
/// [hasCancelButton] 취소 버튼 유무
/// [onPressedCancelButton] 취소 버튼 클릭 시 실행 함수
/// [onPressedCheckButton] 확인 버튼 클릭 시 실행 함수
///
///
Future<void> openPopup(
  BuildContext context, {
  String? title,
  String? firstLineContent,
  String? secondLineContent,
  bool? hasCancelButton,
  required GestureTapCallback onPressedCheckButton,
}) {
  List<Widget> contents = [];

  if (firstLineContent != null) {
    contents.add(Text(
      firstLineContent,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      maxLines: 1,
      softWrap: false,
    ));
  }

  if (secondLineContent != null) {
    contents.add(Text(
      secondLineContent,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      maxLines: 1,
      softWrap: false,
    ));
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: title != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppStyles.highlightText,
                  maxLines: 1,
                )
              ],
            )
          : null,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
      ),
      content: contents.isEmpty
          ? null
          : SingleChildScrollView(
              child: Container(
              width: 300,
              margin: title != null ? null : EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (contents.isNotEmpty)
                    ...contents.map((content) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [content],
                      );
                    }),
                ],
              ),
            )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasCancelButton == true)
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(right: 12.0),
                child: PopupButton(
                  onPressedButton: () => Navigator.of(context).pop(),
                  isCancelButton: true,
                ),
              )),
            Expanded(
              child: PopupButton(
                onPressedButton: () {
                  onPressedCheckButton();
                  Navigator.of(context).pop();
                },
                isCancelButton: false,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

///
/// 팝업 버튼 컴포넌트
///
/// [onPressedButton] 버튼 클릭 시 실행할 함수
/// [isCancelButton] 취소 버튼 여부
///
///
class PopupButton extends StatelessWidget {
  const PopupButton({
    super.key,
    this.onPressedButton,
    required this.isCancelButton,
  });

  final GestureTapCallback? onPressedButton;
  final bool isCancelButton;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedButton,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
            isCancelButton ? AppColor.disabledBgColor : AppColor.secondary),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        )),
      ),
      child: Text(isCancelButton ? '취소' : '확인',
          style:
              TextStyle(color: isCancelButton ? AppColor.dark : Colors.white)),
    );
  }
}
