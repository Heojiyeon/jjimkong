import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/signin/components/validated_input_field.dart';
import 'package:jjimkong/signin/models/validation_result.dart';
import 'package:jjimkong/signin/screens/sign_up_allergy.dart';
import 'package:jjimkong/signin/services/sign_up_service.dart';

final invalidCharPattern = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$\s]');

class SignUpNicknameScreen extends StatefulWidget {
  const SignUpNicknameScreen({super.key});

  @override
  State<SignUpNicknameScreen> createState() => _SignUpNicknameScreenState();
}

class _SignUpNicknameScreenState extends State<SignUpNicknameScreen> {
  final TextEditingController _controller = TextEditingController();
  ValidationResult _validationResult =
      ValidationResult(isValid: false, message: '닉네임을 입력해주세요');

  // Debouncer 객체 생성
  final Debouncer<String> _debouncer = Debouncer<String>(
    const Duration(milliseconds: 500),
    initialValue: '',
    checkEquality: false,
  );

  Future<void> validator(String? value) async {
    String message;
    bool isValid = false;

    if (value == null || value.isEmpty) {
      message = "닉네임을 입력해주세요";
    } else if (invalidCharPattern.hasMatch(value)) {
      message = "특수문자나 띄어쓰기는 사용할 수 없습니다";
    } else if (value.length < 2) {
      message = "2글자 이상의 닉네임을 입력하세요";
    } else if (value.length > 8) {
      message = "8글자 이하의 닉네임을 입력하세요";
    } else {
      final isDuplicate = await SignUpService.getNicknameDuplication(value);
      if (isDuplicate) {
        message = "이미 사용 중인 닉네임입니다";
      } else {
        isValid = true;
        message = "사용 가능한 닉네임입니다";
      }
    }

    setState(() => _validationResult =
        ValidationResult(isValid: isValid, message: message));
  }

  void _onNextButtonPressed() async {
    if (!_validationResult.isValid) return;

    await SignUpService.postNickname(_controller.text);
    await SignUpService.postMenuJobScheduler();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignUpAllergyScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // TextEditingController에 리스너를 추가하여 입력값이 변경될 때마다 Debouncer로 전달
    _controller.addListener(() {
      _debouncer.value = _controller.text;
    });

    _debouncer.values.listen((value) {
      validator(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Description(
              title: '사용할 닉네임을 입력하세요',
              description: '다른 사람들도 볼 수 있는 닉네임이에요.',
            ),
            SizedBox(height: 60),
            ValidatedInputField(
              placeholder: '닉네임 입력',
              controller: _controller,
              validatorResult: _validationResult,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: _onNextButtonPressed,
        text: '다음',
        isDisabled: !_validationResult.isValid,
      ),
    );
  }
}
