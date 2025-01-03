import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/common/widget/input_field.dart';
import 'package:jjimkong/map/screens/place_registration_screen.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

/// 장소 이름을 등록하는 페이지
///
/// 장소 이름 여부에 따라 기본 값을 설정한다.
/// [address] 주소
/// [placeName] 장소명
/// [latLng] 위/경도 좌표
///
class PlaceNameRegistrationScreen extends StatefulWidget {
  final String address;
  final String placeName;
  final LatLng latLng;

  PlaceNameRegistrationScreen({
    super.key,
    required this.address,
    required this.placeName,
    required this.latLng,
  });

  @override
  State<PlaceNameRegistrationScreen> createState() =>
      _PlaceRegistrationScreenState();
}

class _PlaceRegistrationScreenState extends State<PlaceNameRegistrationScreen> {
  TextEditingController _placeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _placeNameController.text = widget.placeName;

    // addListener로 텍스트 값 변화에 따라 상태를 업데이트
    _placeNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 화면 전환을 처리하는 메서드
  void _navigateScreen(Widget screen) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _placeNameController.text = result["placeName"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: "map_app_bar_tag",
          child: BaseAppBar(
            title: "신규 장소 등록",
            onPressedBack: () {
              Navigator.pop(
                context,
                {
                  "address": widget.address,
                  "placeName": widget.placeName,
                  "latLng": widget.latLng
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "map_next_button",
        child: BottomButton(
          isDisabled: _placeNameController.text.isEmpty,
          onPressed: () => _navigateScreen(PlaceRegistrationScreen(
            address: widget.address,
            placeName: _placeNameController.text,
            latLng: widget.latLng,
          )),
          text: "다음",
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: BaseLayout(
          hasHorizontalPadding: true,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Description(
                  appbar: true,
                  title: "장소의 이름을 등록해주세요",
                  description: "재능인들을 위해 정확한 정보를 입력해주세요"),
              InputField(
                  placeholder: "장소명 입력", controller: _placeNameController),
            ],
          ),
        ),
      ),
    );
  }
}
