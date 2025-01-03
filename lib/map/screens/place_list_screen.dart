import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/common/widget/button.dart';
import 'package:jjimkong/map/models/place_model.dart';
import 'package:jjimkong/map/screens/place_select_screen.dart';
import 'package:jjimkong/map/widgets/place_list_item.dart';
import 'package:jjimkong/map/widgets/search_section.dart';

/// 장소 목록 페이지
class PlaceListScreen extends StatefulWidget {
  final List<PlaceModel> places;
  final String? searchValue;
  final TextEditingController controller;
  final Future<List<PlaceModel>> Function() onSearchFn;

  PlaceListScreen(
      {super.key,
      required this.places,
      required this.controller,
      required this.onSearchFn,
      this.searchValue});

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  bool isLoading = false;
  final int pageUnit = 7; // 한번에 불러올 데이터의 개수
  final ScrollController _scrollController = ScrollController();
  List<PlaceModel> _displayedPlaces = []; // 화면에 표시되는 데이터

  @override
  void initState() {
    super.initState();
    // 첫 로딩 시, 7개씩 로드
    _loadMoreData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 스크롤 이벤트 리스너
  void _scrollListener() {
    // 스크롤이 끝에 도달했을 때 데이터 로드
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        _loadMoreData();
      }
    }
  }

  // 데이터 로드 함수 (7개씩 추가)
  Future<void> _loadMoreData() async {
    if (isLoading) return; // 이미 로딩 중이면 중복 로딩 방지
    setState(() {
      isLoading = true;
    });

    // 데이터 로딩 딜레이 (여기서는 더미 지연)
    await Future.delayed(Duration(milliseconds: 800));

    // 다음 7개씩 데이터 추가
    final nextItems = widget.places.sublist(
      _displayedPlaces.length,
      (_displayedPlaces.length + pageUnit) > widget.places.length
          ? widget.places.length
          : _displayedPlaces.length + pageUnit,
    );

    setState(() {
      _displayedPlaces.addAll(nextItems); // 새로운 데이터를 추가
      isLoading = false; // 로딩 끝
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseLayout(
        hasHorizontalPadding: true,
        child: Column(
          children: [
            SearchSection(
              isMapMode: false,
              controller: widget.controller,
              callback: () async {
                var _places = await widget.onSearchFn();
                setState(() {
                  _displayedPlaces = _places;
                });
              },
            ),
            SizedBox(height: widget.places.isEmpty ? 64 : 20),
            widget.places.isEmpty
                ? _buildEmptyList(context)
                : _buildPlaceList(),
          ],
        ),
      ),
    );
  }

  // 리스트가 비었을 때 보여주는 UI
  Widget _buildEmptyList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.info,
          color: AppColor.gray60,
        ),
        SizedBox(height: 8),
        Text(
          "검색 결과가 없습니다. \n 알고 있는 장소가 검색결과에 없다면 \n 직접 장소를 등록해보세요!",
          style: AppStyles.defaultText.copyWith(
            letterSpacing: 0,
            height: 1.5,
            color: AppColor.gray60,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Button(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceSelectScreen(),
              ),
            );
          },
          text: "신규 장소 등록",
          textColorState: ButtonTextType.secondary,
          backgroundColorState: ButtonBGType.secondary10,
          sizeState: ButtonSize.medium,
        ),
      ],
    );
  }

  // 장소 리스트 아이템 표시 UI
  Widget _buildPlaceList() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            _displayedPlaces.length + (isLoading ? 1 : 0), // 로딩 중이면 1개 추가
        itemBuilder: (context, index) {
          if (index == _displayedPlaces.length) {
            return Center(child: CircularProgressIndicator()); // 로딩 중인 상태 표시
          }

          var placeId = _displayedPlaces[index].restaurantId!;
          var placeName = _displayedPlaces[index].restaurantName;
          var category = _displayedPlaces[index].category;
          var description = _displayedPlaces[index].description;
          var visitorCount = _displayedPlaces[index].checkCount ?? 0;

          return PlaceListItem(
            placeId: placeId,
            placeName: placeName,
            category: category,
            description: description,
            visitorCount: visitorCount,
          );
        },
      ),
    );
  }
}
