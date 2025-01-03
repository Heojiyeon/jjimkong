import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 기본 입력 위젯
/// 이 위젯은 텍스트 입력을 위한 필드로, 사용자로부터 텍스트 입력을 받는데 사용한다.
///
/// [placeholder] 입력 필드의 힌트 텍스트
/// [limitLength] 텍스트 길이를 제한하는 값
/// [controller] 텍스트 필드 컨트롤러
/// [textInputAction] 입력 액션 (Default: done)
/// [textInputType] 입력 타입 (Default: text)
///
class InputField extends StatefulWidget {
  final String placeholder;
  final int? limitLength;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool shouldDispose;

  const InputField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.textInputAction,
    this.textInputType,
    this.limitLength,
    this.shouldDispose = true,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

/// [InputField] 위젯의 상태를 관리하는 클래스
class _InputFieldState extends State<InputField> {
  int _textLength = 0; // 현재 입력된 텍스트 길이

  /// 입력 박스 라인 스타일 정의
  static OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: AppColor.gray20),
    borderRadius: BorderRadius.circular(6),
  );

  /// 입력 박스 내부 스타일 정의
  static InputDecoration _inputDecoration = InputDecoration(
    filled: true,
    border: _borderStyle,
    fillColor: Colors.white,
    enabledBorder: _borderStyle,
    focusedBorder: _borderStyle,
    hintStyle: AppStyles.defaultText.copyWith(color: AppColor.gray60),
    contentPadding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 12),
  );

  /// 입력 필드 업데이트 함수
  void _updateInputField() {
    // 변경점이 있는 경우만 업데이트
    final currentLength = widget.controller.text.length;
    if (widget.limitLength != null && currentLength != _textLength) {
      setState(() {
        _textLength = currentLength;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalInputLine =
        widget.textInputType == TextInputType.multiline ? 5 : 1; // 입력 필드 총 라인 수

    return TextField(
      controller: widget.controller,
      minLines: totalInputLine,
      maxLines: totalInputLine,
      textAlign: TextAlign.start,
      style: AppStyles.defaultText,
      keyboardType: widget.textInputType ?? TextInputType.text,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      decoration: _inputDecoration.copyWith(
        hintText: widget.placeholder,
        counterText: widget.limitLength != null
            ? "$_textLength/${widget.limitLength}"
            : null,
      ),
      inputFormatters: [
        if (widget.limitLength != null)
          LengthLimitingTextInputFormatter(widget.limitLength),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateInputField);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.shouldDispose) widget.controller.dispose();
  }
}

/// 위젯북 - 기본 입력 필드
@widgetbook.UseCase(name: "Default", type: InputField)
Center defaultInputField(BuildContext context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: InputField(
      placeholder: "이름 입력",
      controller: TextEditingController(),
    ),
  ));
}

/// 위젯북 - 검색 입력 필드
@widgetbook.UseCase(name: "Search", type: InputField)
Center searchInputField(BuildContext context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: InputField(
      placeholder: "이름 검색",
      controller: TextEditingController(),
      textInputAction: TextInputAction.search,
    ),
  ));
}

/// 위젯북 - 멀티라인 입력 필드
@widgetbook.UseCase(name: "Mulitline", type: InputField)
Center mulitlineInputField(BuildContext context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: InputField(
      placeholder: "재능인들을 위한 후기를 남겨주세요.",
      controller: TextEditingController(),
      textInputType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      limitLength: 200,
    ),
  ));
}
