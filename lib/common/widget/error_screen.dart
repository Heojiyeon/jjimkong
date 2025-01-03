import 'package:flutter/material.dart';
import 'package:jjimkong/common/util/sign_out.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';

class ErrorScreen extends StatelessWidget {
  final String? errorCode;

  const ErrorScreen({
    super.key,
    this.errorCode = 'Unknown',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$errorCode Error'),
      ),
      bottomNavigationBar: BottomButton(
        text: '로그인으로 이동',
        onPressed: signOut,
      ),
    );
  }
}
