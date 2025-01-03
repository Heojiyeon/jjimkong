import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';

/// 스타일과 현재 페이지의 타이틀이 적용된 Appbar
///
/// [title]은 현재 페이지의 타이틀
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // 현재 페이지의 타이틀
  final void Function()? onPressedBack;

  const BaseAppBar({super.key, required this.title, this.onPressedBack});

  /// 뒤로가기 버튼 위젯
  Widget chevronSvgIcon() {
    return SvgPicture.asset(
      'assets/images/ic-chevron.svg',
      colorFilter: ColorFilter.mode(
        AppColor.dark,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: chevronSvgIcon(),
        onPressed: () {
          if (onPressedBack != null) {
            onPressedBack!();
            return;
          }

          Navigator.of(context).pop();
        },
      ),
      title: Text(
        title,
        style: AppStyles.subTitle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
