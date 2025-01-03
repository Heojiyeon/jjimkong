import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/map/screens/place_name_registration_screen.dart';
import 'package:jjimkong/map/widgets/place_seelctor.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

/// 신규 장소 등록(장소 선택) 페이지
class PlaceSelectScreen extends StatefulWidget {
  @override
  State<PlaceSelectScreen> createState() => _PlaceSelectScreenState();
}

class _PlaceSelectScreenState extends State<PlaceSelectScreen> {
  String _address = "";
  String _placeName = "";
  late LatLng? _latLng;

  void _selectPlaceAddress(String? address, String? placeName, LatLng? latLng) {
    setState(() {
      _address = address ?? "";
      _placeName = placeName ?? "";
      _latLng = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 화면 전환을 처리하는 메서드
    void _navigateScreen(Widget screen) async {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

      if (result != null) {
        setState(() {
          _address = result["address"];
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: "map_app_bar_tag",
          child: BaseAppBar(
            title: "신규 장소 등록",
          ),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "map_next_button",
        child: BottomButton(
            isDisabled: _address.isEmpty,
            onPressed: () {
              if (_address == "" || _latLng == null) return;
              _navigateScreen(PlaceNameRegistrationScreen(
                  address: _address, placeName: _placeName, latLng: _latLng!));
            },
            text: "다음"),
      ),
      body: BaseLayout(
        hasHorizontalPadding: false,
        child: Container(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Description(
                    appbar: true,
                    title: "장소를 선택해 주세요",
                    description: "회사 주변 장소만 등록 가능해요"),
              ),
              PlaceSelector(selectPlaceAddress: _selectPlaceAddress),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  _address.isEmpty
                      ? "올바른 장소를 선택해 주세요."
                      : "$_address $_placeName",
                  style: TextStyle(
                    fontFamily: "Pretendard",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
