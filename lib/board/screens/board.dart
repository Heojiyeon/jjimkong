import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jjimkong/board/widgets/snow.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import "dart:math";

class BoardScreen extends StatefulWidget {
  final void Function(bool value)? onNavVisible;

  const BoardScreen({super.key, this.onNavVisible});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late final WebViewController controller;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  bool _isSnowing = false; // 눈 내리는 상태
  final double _shakeThreshold = 15.0; // 흔들림 감지 기준값
  DateTime _lastShakeTime = DateTime.now(); // 마지막 흔들림 시간
  double _totalAcceleration = 0.0; // 전체 가속도 센서 값
  double _speed = 0.4; // 눈 내리는 속도
  int _snowCount = 20; // 눈 내리는 양

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..loadRequest(Uri.parse('http://192.1.31.166:5173/'));
    controller.addJavaScriptChannel('messageHandler',
        onMessageReceived: (JavaScriptMessage message) {
      if (message.message == 'hide') {
        widget.onNavVisible!(false);
      } else if (message.message == 'visible') {
        widget.onNavVisible!(true);
      }
    });

    // 가속도 센서 값 리스닝
    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      _totalAcceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );

      // 기준을 초과하는 가속도 변화가 감지되면 눈 내리기 시작
      if (_totalAcceleration > _shakeThreshold) {
        _speed = _totalAcceleration > 20 ? 0.9 : 0.5;
        _snowCount = _totalAcceleration > 20 ? 35 : 20;

        // 흔들림이 일정 간격 이상일 때만 처리
        if (DateTime.now().difference(_lastShakeTime).inMilliseconds > 500) {
          setState(() {
            _isSnowing = true;
            _lastShakeTime = DateTime.now();
          });

          // 일정 시간 후 눈 내림 중지
          Future.delayed(Duration(seconds: 5), () {
            if (mounted) {
              setState(() {
                _isSnowing = false;
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
        ),
        if (_isSnowing)
          SnowWidget(
            totalSnow: _snowCount,
            speed: _speed,
            isRunning: _isSnowing,
            snowColor: Colors.white,
            maxRadius: 6,
          ),
      ],
    );
  }
}
