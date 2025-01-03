import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/util/open_popup.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/bottom_button.dart';
import 'package:jjimkong/common/widget/description.dart';
import 'package:jjimkong/common/widget/input_field.dart';
import 'package:jjimkong/map/models/place_model.dart';
import 'package:jjimkong/map/screens/place_detail_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/utils/map_category.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

/// 장소 등록 페이지
///
/// 장소 카테고리 및 설명글을 입력후 API 통신을 한다.
/// [address] 주소
/// [placeName] 장소명
/// [latLng] 위/경도 좌표
///
class PlaceRegistrationScreen extends StatefulWidget {
  final String address;
  final String? placeName;
  final LatLng latLng;

  const PlaceRegistrationScreen({
    super.key,
    required this.address,
    this.placeName,
    required this.latLng,
  });

  @override
  State<PlaceRegistrationScreen> createState() =>
      _PlaceRegistrationScreenState();
}

class _PlaceRegistrationScreenState extends State<PlaceRegistrationScreen> {
  TextEditingController _descriptionTextController = TextEditingController();
  int? _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _descriptionTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라오면 화면이 자동으로 재배치되도록 설정
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: "map_app_bar_tag",
          child: BaseAppBar(
            title: "신규 장소 등록",
            onPressedBack: () {
              Navigator.pop(context,
                  {"address": widget.address, "placeName": widget.placeName});
            },
          ),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "map_next_button",
        child: BottomButton(
            isDisabled: _descriptionTextController.text.isEmpty,
            onPressed: () async {
              var description = _descriptionTextController.text;
              var category =
                  MapCategory().findCategoryByIndex(_selectedValue! - 1);

              PlaceModel place = PlaceModel(
                  restaurantName: widget.placeName!,
                  address: widget.address,
                  description: description,
                  category: category.key,
                  latitude: '${widget.latLng.latitude}',
                  longitude: '${widget.latLng.longitude}');

              var restaurantId = await MapService.postPlace(place);

              if (mounted) {
                if (restaurantId != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      openPopup(context,
                          title: "신규 장소 등록", firstLineContent: "성공적으로 등록되었습니다.",
                          onPressedCheckButton: () {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceDetailScreen(
                              restaurantId: restaurantId,
                            ),
                          ),
                        );
                      });
                    }
                  });
                }
              }
            },
            text: "등록"),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: BaseLayout(
          hasHorizontalPadding: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Description(
                    appbar: true,
                    title: "장소 설명을 추가해주세요",
                    description: "재능인들을 위해 정확한 정보를 입력해주세요"),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.gray05,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 72,
                  child: _buildPlaceInfoLabel(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 36),
                  width: double.infinity,
                  child: Column(
                    children: [
                      FormLabel(labelName: "카테고리", isRequired: true),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(
                          MapCategory.options.length,
                          (index) => _buildCustomRadioButton(
                            index + 1,
                            MapCategory().findCategoryByIndex(index).value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  child: Column(
                    children: [
                      FormLabel(labelName: "설명글", isRequired: true),
                      InputField(
                        placeholder: "어떤 메뉴가 유명한가요?\n장소나 메뉴 정보를 포함하면 도움이 돼요.",
                        limitLength: 300,
                        controller: _descriptionTextController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRadioButton(int value, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedValue = value;
        });
      },
      child: Container(
        width: 86,
        height: 38,
        decoration: BoxDecoration(
          color: _selectedValue == value ? AppColor.primary10 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                _selectedValue == value ? AppColor.primary10 : AppColor.gray20,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color:
                  _selectedValue == value ? AppColor.primary : AppColor.gray40,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Column _buildPlaceInfoLabel() {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.placeName ?? "",
            style: AppStyles.highlightText.copyWith(color: AppColor.gray80)),
        Text(
          widget.address,
          style: AppStyles.defaultText.copyWith(color: AppColor.gray60),
        ),
      ],
    );
  }
}

class FormLabel extends StatelessWidget {
  final String labelName;
  final bool isRequired;

  const FormLabel({
    super.key,
    required this.labelName,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            labelName,
            style: AppStyles.highlightText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isRequired)
            Text("*", style: TextStyle(color: Colors.red, fontSize: 20)),
        ],
      ),
    );
  }
}
