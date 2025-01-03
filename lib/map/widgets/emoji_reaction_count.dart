import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

/// 이모지 반응 수 위젯
///
/// [emojiSvgName] 이모지 이름
/// [count] 반응 수
///
class EmojiReactionCount extends StatelessWidget {
  final String emojiType;
  final int count;

  const EmojiReactionCount({
    super.key,
    required this.emojiType,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SVGIcon(
          svgName: emojiType == "01" ? "ic-emoji-smile" : "ic-emoji-bad",
          iconSize: IconSize.medium,
          color: emojiType == "01" ? AppColor.primary : AppColor.secondary,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "$count",
          style: AppStyles.subText.copyWith(color: AppColor.gray40),
        ),
      ],
    );
  }
}
