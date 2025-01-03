import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

/// 이모지 리액션 차트 위젯
///
/// [positiveCount] 긍정 반응 수
/// [negativeCount] 부정 반응 수
///
class EmojiReactionChart extends StatelessWidget {
  final int positiveCount;
  final int negativeCount;

  const EmojiReactionChart({
    super.key,
    required this.positiveCount,
    required this.negativeCount,
  });

  @override
  Widget build(BuildContext context) {
    var totalCount = positiveCount + negativeCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 차트
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            "단위: 명",
            style: AppStyles.subTitle.copyWith(
              fontSize: 10,
              color: AppColor.gray40,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          height: 64,
          child: Stack(
            children: [
              Positioned(
                top: 36,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 15,
                  child: Row(
                    children: [
                      if (totalCount == 0)
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: AppColor.gray10,
                          ),
                        ),
                      Expanded(
                        flex: negativeCount,
                        child: Container(
                          color: AppColor.secondary40,
                        ),
                      ),
                      Expanded(
                        flex: positiveCount,
                        child: Container(
                          color: AppColor.primary40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 2,
                left: 0,
                child: EmojiReactionItem(
                  count: negativeCount,
                  emojiType: "02",
                ),
              ),
              Positioned(
                top: 2,
                right: 0,
                child: EmojiReactionItem(
                  count: positiveCount,
                  emojiType: "01",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// 이모지 반응 아이템 위젯
///
/// [count] 반응수
class EmojiReactionItem extends StatelessWidget {
  final int count;
  final String emojiType;

  const EmojiReactionItem({
    super.key,
    required this.count,
    required this.emojiType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$count"),
        Container(
          width: 36,
          height: 36,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColor.gray10,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SVGIcon(
            svgName: emojiType == "01" ? "ic-emoji-smile" : "ic-emoji-bad",
            iconSize: IconSize.medium,
            color: emojiType == "01" ? AppColor.primary : AppColor.secondary,
          ),
        ),
      ],
    );
  }
}
