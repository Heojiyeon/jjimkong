import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

/// 장소 선택 위젯
///
/// 범위내에 장소를 선택한다.
/// [Function] selectPlaceAddress 장소 선택후 후처리 함수
///
class PlaceSelector extends StatefulWidget {
  final void Function(String? address, String? placeName, LatLng? latLng)
      selectPlaceAddress;

  const PlaceSelector({
    super.key,
    required this.selectPlaceAddress,
  });

  @override
  State<PlaceSelector> createState() => _PlaceSelectorState();
}

class _PlaceSelectorState extends State<PlaceSelector> {
  final List<Marker> _markers = [];
  static LatLng _companyLatLng = LatLng(37.587871, 127.002197);
  static String _companyMarkerSrc = "https://i.ibb.co/JBYrCbn/ic-marker.png";
  static const double _circleRadius = 1200.0;
  late KakaoMapController _controller;
  bool _isMapReady = false;

  /// 기본 마커(회사 위치) 초기 등록
  void _initializeMarkers() {
    final Marker companyMarker = Marker(
      markerId: "company_marker",
      latLng: _companyLatLng,
      width: 34,
      height: 46,
      offsetY: 6,
      markerImageSrc: _companyMarkerSrc,
    );

    setState(() {
      _markers.add(companyMarker);
    });
  }

  /// 회사를 기준으로 특정 범위내에 존재하는지 여부를 확인하는 함수
  bool _isWithinCircle(LatLng point, LatLng center, double radiusInMeters) {
    final double distance = Geolocator.distanceBetween(
      point.latitude,
      point.longitude,
      center.latitude,
      center.longitude,
    );
    return distance <= radiusInMeters;
  }

  /// 맵을 탭했을 때 동작하는 함수
  void _handleMapTap(LatLng latLng) async {
    if (_isWithinCircle(latLng, _companyLatLng, _circleRadius)) {
      _updateMarker(latLng);

      final request = Coord2AddressRequest(
        x: latLng.latitude,
        y: latLng.longitude,
      );

      final response = await _controller.coord2Address(request);
      final keywordRequest = KeywordSearchRequest(
          keyword: response.list.first.roadAddress?.addressName ?? "");
      final keywordResponse = await _controller.keywordSearch(keywordRequest);
      final place = keywordResponse.list.isEmpty
          ? null
          : keywordResponse.list.first.placeName;

      widget.selectPlaceAddress(
          response.list.first.address?.addressName, place, latLng);
    } else {
      widget.selectPlaceAddress(null, null, null);
      setState(() {
        _markers.removeAt(1);
      });
    }
  }

  /// 마커 목록을 업데이트하는 함수
  void _updateMarker(LatLng point) {
    // 새 마커 추가
    final Marker newMarker = Marker(
      markerId: "user_selected_marker",
      latLng: point,
      width: 34,
      height: 46,
    );

    setState(() {
      if (_markers.length > 1) {
        _markers.removeAt(1);
      }
      _markers.add(newMarker);
    });
  }

  /// 카카오맵 생성 후 설정 함수
  void _setupMap(KakaoMapController controller) async {
    _controller = controller;
    _initializeMarkers();

    final Circle circle = Circle(
      circleId: "boundary_circle",
      center: _companyLatLng,
      radius: _circleRadius,
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withValues(alpha: 0.1),
      fillOpacity: 0.1,
    );
    await controller.addCircle(circles: [circle]);

    setState(() {
      _isMapReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 402,
      child: Stack(
        children: [
          KakaoMap(
            center: _companyLatLng,
            onMapCreated: _setupMap,
            onMapTap: _handleMapTap,
            markers: _markers,
            zoomControl: true,
          ),
          if (!_isMapReady)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
