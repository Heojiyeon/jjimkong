import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

enum ButtonType { jjimkong, review, cancel }

class ButtonStyles {
  static Map<String, dynamic> getStyles(ButtonType type, bool isChecked) {
    if (type == ButtonType.review) {
      return {
        "iconName": "ic-review",
        "color": Color(0xFF87D4F7),
        "text": "후기",
      };
    }

    if (type == ButtonType.jjimkong) {
      return {
        "iconName": "ic-jjimkong",
        "color": isChecked ? AppColor.primary : AppColor.disabledTextColor,
        "text": "찜콩",
      };
    }

    return {
      "iconName": "ic-jjimkong",
      "color": AppColor.primary,
      "text": "취소",
    };
  }
}

class JJimKongButton extends StatefulWidget {
  final ButtonType type; // 버튼 타입(찜콩 버튼 / 리뷰 버튼 / 취소 버튼)
  final bool isChecked; // 선택 체크 여부
  final VoidCallback onPressed;

  JJimKongButton({
    super.key,
    required this.type,
    required this.isChecked,
    required this.onPressed,
  });

  @override
  State<JJimKongButton> createState() => _JJimKongButtonState();
}

class _JJimKongButtonState extends State<JJimKongButton> {
  @override
  Widget build(BuildContext context) {
    var style = ButtonStyles.getStyles(widget.type, widget.isChecked);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 16,
        ),
        side: BorderSide(
          color: AppColor.gray10,
          width: 1,
        ),
      ),
      onPressed: widget.onPressed,
      child: Row(
        spacing: 4,
        children: [
          SVGIcon(
            svgName: style["iconName"],
            iconSize: IconSize.small,
            color: style["color"],
          ),
          Text(
            style["text"],
            style: AppStyles.defaultText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
