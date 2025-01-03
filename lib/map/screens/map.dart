import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';
import 'package:jjimkong/map/models/place_model.dart';
import 'package:jjimkong/map/screens/place_list_screen.dart';
import 'package:jjimkong/map/screens/place_select_screen.dart';
import 'package:jjimkong/map/screens/today_jjimkong_list_screen.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/utils/fade_navigate.dart';
import 'package:jjimkong/map/utils/map_category.dart';
import 'package:jjimkong/map/widgets/place_details_sheet.dart';
import 'package:jjimkong/map/widgets/floating_button.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:jjimkong/map/widgets/map_header.dart';

/// 외식 페이지 위젯
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapAppState();
}

class _MapAppState extends State<MapScreen> {
  List<Marker> _markers = [];
  bool _isMapReady = false;
  List<PlaceModel> _places = [];
  Clusterer? clusterer;
  late KakaoMapController _mapController;
  bool _isBottomSheetOpen = false;

  // 검색
  TextEditingController _searchValueController = TextEditingController();
  String _searchCategory = "전체";

  static LatLng _companyLatLng = LatLng(37.587871, 127.002197);
  static const _companyMarkerSrc = "https://i.ibb.co/JBYrCbn/ic-marker.png";

  /// 맵 생성시 콜백으로 실행될 메서드
  void _onMapCreated(KakaoMapController controller) async {
    if (mounted) {
      setState(() {
        _mapController = controller;
        _isMapReady = true;
        _loadData();
      });
    }

    setState(() {});
  }

  /// 라디오 버튼 값을 관리하는 메서드
  void _changeRadioButtonValue(String value) {
    _mapController.clearMarkerClusterer();
    _mapController.clearMarker();
    setState(() {
      _markers = [];
      _searchCategory = value;
    });

    _loadData(category: MapCategory().getKeyFromValue(value));
  }

  /// 화면 전환을 처리하는 메서드
  void _navigateScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  String _getMarkerSrc(String category) {
    if (category == "FP") return "https://i.ibb.co/1JWsGhH/ic-bread.png";
    if (category == "CF") return "https://i.ibb.co/2hxhYvV/ic-coffee.png";
    return "https://i.ibb.co/4s4JRyG/ic-food.png";
  }

  /// 데이터 로드 메서드
  Future<void> _loadData({String? category, String? searchValue}) async {
    var places = await MapService.getAllPlaces();
    if (searchValue != null && searchValue.isNotEmpty) {
      _places = places.where((place) {
        return place.restaurantName.contains(searchValue);
      }).toList();
    } else {
      _searchValueController.text = "";
      if (category == null || category == "") {
        _places = places;
      } else {
        _places = places.where((place) {
          return place.category == category;
        }).toList();
      }
    }

    _markers = [];
    var companyMarker = Marker(
      markerId: "company-marker",
      width: 34,
      height: 46,
      offsetY: 6,
      latLng: _companyLatLng,
      markerImageSrc: _companyMarkerSrc,
    );

    List<Marker> markers;
    markers = _places.map((place) {
      var latitude = double.tryParse(place.latitude) ?? 0.0;
      var longitude = double.tryParse(place.longitude) ?? 0.0;
      return Marker(
        markerId: place.restaurantId!,
        latLng: LatLng(latitude, longitude),
        width: 34,
        height: 34,
        markerImageSrc: _getMarkerSrc(place.category),
      );
    }).toList();

    markers.add(companyMarker);
    // 클러스터 생성
    clusterer = Clusterer(
      markers: _markers.toList(),
      minLevel: 4,
      calculator: [4, 8, 14],
      gridSize: 90,
      minClusterSize: 3,
    );

    setState(() {
      _markers = markers;
    });
  }

  void _showModalBottomSheet(BuildContext context, String markerId) {
    if (_isBottomSheetOpen) Navigator.pop(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        _isBottomSheetOpen = true;
        return PlaceDetailsSheet(restaurantId: markerId);
      },
    ).whenComplete(() {
      _isBottomSheetOpen = false;
    });
  }

  Future<List<PlaceModel>> _onSearch() async {
    await _loadData(category: "", searchValue: _searchValueController.text);

    setState(() {
      _searchValueController.text = _searchValueController.text;
    });

    return _places;
  }

  void _navigateList() {
    Navigator.push(
      context,
      fadeInPageRoute(PlaceListScreen(
        places: _places,
        searchValue: _searchValueController.text,
        controller: _searchValueController,
        onSearchFn: _onSearch,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        hasHorizontalPadding: false,
        child: Column(
          children: [
            MapHeader(
              searchCategory: _searchCategory,
              searchValue: _searchValueController.text,
              changeCategoryFn: _changeRadioButtonValue,
              searchValueController: _searchValueController,
              onSearchFn: () async {
                await _onSearch();
                _navigateList();
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  KakaoMap(
                    markers: _markers,
                    clusterer: clusterer,
                    center: _companyLatLng,
                    onMapCreated: _onMapCreated,
                    onMarkerTap: (markerId, latLng, zoomLevel) {
                      if (markerId == "company-marker") return;

                      _mapController.setCenter(latLng);
                      _showModalBottomSheet(context, markerId);
                    },
                  ),
                  FloatingButton(
                    top: 20,
                    text: "오늘 찜콩",
                    icon: "ic-jjimkong",
                    variant: AppColor.primary,
                    onPressed: () => _navigateScreen(TodayJjimkongListScreen()),
                  ),
                  FloatingButton(
                    top: 96,
                    text: "장소 등록",
                    icon: "ic-map-register",
                    variant: AppColor.secondary,
                    onPressed: () => _navigateScreen(PlaceSelectScreen()),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 118,
                        height: 38,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              fadeInPageRoute(PlaceListScreen(
                                places: _places,
                                controller: _searchValueController,
                                onSearchFn: _onSearch,
                              )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SVGIcon(
                                  svgName: "ic-list",
                                  iconSize: IconSize.small,
                                  color: AppColor.primary),
                              Text(
                                "목록보기",
                                style: AppStyles.defaultText.copyWith(
                                  color: AppColor.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          _mapController.setCenter(_companyLatLng);
                        },
                        icon: SVGIcon(
                          svgName: "ic-building",
                          iconSize: IconSize.medium,
                        ),
                      ),
                    ),
                  ),
                  if (!_isMapReady)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
