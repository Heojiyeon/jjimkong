import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

/// 버튼 varient enum
/// 배경색, 텍스트색, 보더 여부, 버튼 사이즈, border-radius, 버튼 활성 상태
enum ButtonBGType {
  primary,
  primary10,
  secondary,
  secondary10,
  disabled,
  basic,
  cancel,
}

enum ButtonTextType {
  primary,
  secondary,
  disabled,
  dark,
  white,
}

enum ButtonOutline {
  basic,
  outline,
}

enum ButtonSize {
  medium,
  large,
  icon,
  full,
}

enum ButtonBorder {
  basic,
  rounded,
}

enum ButtonState {
  active,
  disabled,
}

// 버튼 스타일 정의 varient class
class ButtonStyles {
  // 버튼 활성 상태
  static const Map<ButtonState, bool> buttonState = {
    ButtonState.active: true,
    ButtonState.disabled: false,
  };

  // 배경 색
  static const Map<ButtonBGType, Color> backgroundColor = {
    ButtonBGType.primary: AppColor.primary,
    ButtonBGType.primary10: AppColor.primary10,
    ButtonBGType.secondary: AppColor.secondary,
    ButtonBGType.secondary10: AppColor.secondary10,
    ButtonBGType.disabled: AppColor.disabledBgColor,
    ButtonBGType.basic: Colors.white,
    ButtonBGType.cancel: AppColor.disabledBgColor,
  };

  // 텍스트 색
  static const Map<ButtonTextType, Color> textColor = {
    ButtonTextType.primary: AppColor.primary,
    ButtonTextType.secondary: AppColor.secondary,
    ButtonTextType.disabled: AppColor.disabledTextColor,
    ButtonTextType.dark: AppColor.dark,
    ButtonTextType.white: Colors.white,
  };

  // 버튼 보더 너비
  static const Map<ButtonOutline, bool> outline = {
    ButtonOutline.basic: false,
    ButtonOutline.outline: true,
  };

// 버튼 사이즈
  static const Map<ButtonSize, Size> buttonSize = {
    ButtonSize.medium: Size(96.0, 38.0),
    ButtonSize.large: Size(116.0, 44.0),
    ButtonSize.icon: Size(44.0, 44.0),
  };

  // 버튼 border-radius
  static const Map<ButtonBorder, double> buttonBorder = {
    ButtonBorder.basic: 6.0,
    ButtonBorder.rounded: 100.0,
  };
}

///
/// 버튼 컴포넌트
///
/// [text] 버튼 내 텍스트
/// [icon] 버튼 내 아이콘 (SVGIcon 위젯 생성 후 전달 필요)
/// [buttonState] 버튼 활성 상태 / active(활성), disabled(비활성)
/// [backgroundColorState] 버튼 배경 색상 / 정의된 색상 코드 참고
/// [textColorState] 버튼 텍스트 색상 / 정의된 색상 코드 참고
/// [hasOutLineState] 버튼 테두리 여부 / basic(테두리 X), rounded(테두리 O)
/// [sizeState] 버튼 사이즈 / medium, large, icon
/// [borderState] 버튼 border-radius 상태 / basic(기본), rounded(원형)
///
///
class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonState = ButtonState.active,
    this.backgroundColorState = ButtonBGType.primary,
    this.textColorState = ButtonTextType.primary,
    this.hasOutLineState = ButtonOutline.basic,
    this.sizeState = ButtonSize.medium,
    this.borderState = ButtonBorder.basic,
  });

  final GestureTapCallback onPressed;
  final String? text;
  final Widget? icon;
  final ButtonState buttonState;
  final ButtonBGType backgroundColorState;
  final ButtonTextType textColorState;
  final ButtonOutline hasOutLineState;
  final ButtonSize sizeState;
  final ButtonBorder borderState;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: buttonState == ButtonState.active ? onPressed : null,
        style: ButtonStyle(
          alignment: Alignment.center,
          minimumSize: WidgetStateProperty.all<Size>(Size.zero),
          fixedSize: WidgetStateProperty.all<Size>(
              ButtonStyles.buttonSize[sizeState]!),
          backgroundColor: WidgetStateProperty.all(
              ButtonStyles.backgroundColor[backgroundColorState]),
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ButtonStyles.buttonBorder[borderState]!),
            side: BorderSide(
              color: hasOutLineState == ButtonOutline.basic
                  ? Colors.transparent
                  : ButtonStyles.textColor[textColorState]!,
            ),
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null && text != null)
              SizedBox(
                width: 4,
              ),
            Text(
              text ?? "",
              style: TextStyle(
                color: ButtonStyles.textColor[textColorState],
                fontSize: 14,
              ),
              maxLines: 1,
            )
          ],
        ));
  }
}

@UseCase(name: "Default", type: Button)
Widget defaultButton(BuildContext context) {
  return Center(
    child: Button(
      textColorState: ButtonTextType.white,
      text: "확인",
      onPressed: () {},
    ),
  );
}

@UseCase(name: "Secondary", type: Button)
Widget secondaryButton(BuildContext context) {
  return Center(
    child: Button(
      backgroundColorState: ButtonBGType.secondary,
      textColorState: ButtonTextType.white,
      text: "확인",
      onPressed: () {},
    ),
  );
}

@UseCase(name: "Disabled", type: Button)
Widget disabledButton(BuildContext context) {
  return Center(
    child: Button(
      buttonState: ButtonState.disabled,
      backgroundColorState: ButtonBGType.disabled,
      textColorState: ButtonTextType.disabled,
      text: "확인",
      onPressed: () {},
    ),
  );
}

@UseCase(name: "OutlineDefault", type: Button)
Widget outlineButton(BuildContext context) {
  return Center(
    child: Button(
      hasOutLineState: ButtonOutline.outline,
      textColorState: ButtonTextType.primary,
      backgroundColorState: ButtonBGType.basic,
      text: "확인",
      onPressed: () {},
    ),
  );
}

@UseCase(name: "OutlineSecondary", type: Button)
Widget outlineSecondaryButton(BuildContext context) {
  return Center(
    child: Button(
      hasOutLineState: ButtonOutline.outline,
      backgroundColorState: ButtonBGType.basic,
      textColorState: ButtonTextType.secondary,
      text: "확인",
      onPressed: () {},
    ),
  );
}
