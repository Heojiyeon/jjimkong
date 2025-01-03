import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/input_field.dart';
import 'package:jjimkong/signin/models/validation_result.dart';

///
/// 유효성 검사가 포함된 입력 위젯
/// 텍스트 입력 필드 위젯으로, 입력값에 대한 유효성 검사를 포함한다.
///
/// [placeholder] 입력 필드의 힌트 텍스트
/// [controller] 텍스트 필드 컨트롤러
/// [validatorResult] 유효성 검사 결과
///
class ValidatedInputField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final ValidationResult validatorResult;

  const ValidatedInputField({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.validatorResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          placeholder: placeholder,
          controller: controller,
        ),
        ValidationMessage(
          isValid: validatorResult.isValid,
          message: validatorResult.message,
        ),
      ],
    );
  }
}

/// 입력창 validation 결과 텍스트 및 아이콘
/// [isValid] 유효한 문자인지 여부
/// [message] 유효성 결과 메세지
///
class ValidationMessage extends StatelessWidget {
  final bool isValid;
  final String message;

  ValidationMessage({super.key, required this.isValid, required this.message});

  @override
  Widget build(BuildContext context) {
    var icon = isValid ? 'ic-valid.svg' : 'ic-invalid.svg';
    var textColor =
        isValid ? AppColor.validTextColor : AppColor.inValidTextColor;

    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset("assets/images/$icon"),
          const SizedBox(width: 2),
          Text(
            message,
            style: AppStyles.subText.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
