import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/signin/services/auth_service.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ic-logo-white.svg',
                width: 90,
                height: 74,
              ),
              const SizedBox(height: 277),
              FilledButton(
                onPressed: AuthService.hasToAuth
                    ? () => AuthService.googleAuthService(context)
                    : null, // 이미 인증된 경우 버튼 비활성화
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                ),
                child: SvgPicture.asset(
                  'assets/images/img-google-button.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
