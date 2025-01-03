import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

class ButtonStyles {
  static Map<String, dynamic> getStyles(String isPositiveReview, String title) {
    var isPositiveReviewState = isPositiveReview == title;
    if (title == 'positive') {
      return {
        "backgroundColor":
            isPositiveReviewState ? AppColor.primary10 : Colors.white,
        "icon": isPositiveReviewState ? AppColor.primary : AppColor.dark,
        "color": isPositiveReviewState ? AppColor.primary : AppColor.gray60,
      };
    } else {
      return {
        "backgroundColor":
            isPositiveReviewState ? AppColor.secondary10 : Colors.white,
        "icon": isPositiveReviewState ? AppColor.secondary : AppColor.dark,
        "color": isPositiveReviewState ? AppColor.secondary : AppColor.gray60,
      };
    }
  }
}

class ReviewButton extends StatelessWidget {
  final String isPositiveReview;
  final String title;
  final void Function(String value) setIsPositiveReview;

  const ReviewButton({
    super.key,
    required this.isPositiveReview,
    required this.title,
    required this.setIsPositiveReview,
  });

  @override
  Widget build(BuildContext context) {
    var style = ButtonStyles.getStyles(isPositiveReview, title);

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 30,
      child: TextButton(
        onPressed: () => setIsPositiveReview(title),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          minimumSize: Size.zero, // 최소 크기 제거
          backgroundColor: style['backgroundColor'],
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color: AppColor.gray20,
              width: isPositiveReview == title ? 0 : 1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SVGIcon(
              svgName: title == 'positive' ? "ic-emoji-smile" : 'ic-emoji-bad',
              iconSize: IconSize.xlarge,
              color: style['icon'],
            ),
            SizedBox(height: 10),
            Text(
              title == 'positive' ? '만족해요' : '아쉬워요',
              style: AppStyles.highlightText.copyWith(
                color: style['color'],
                height: 1.1875,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
