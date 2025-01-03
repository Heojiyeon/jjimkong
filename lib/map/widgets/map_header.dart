import 'package:flutter/material.dart';
import 'package:jjimkong/common/widget/radio_button.dart';
import 'package:jjimkong/map/widgets/search_section.dart';

/// MapHeader 위젯
///
/// Map(외식) 페이지 헤더 영역
/// [currentValue] 현재 선택된 라디오 버튼 값
/// [onChange] 라디오 버튼 현재 값을 변경할 함수
class MapHeader extends StatefulWidget {
  const MapHeader({
    super.key,
    required String searchValue,
    required String searchCategory,
    required void Function(String value) changeCategoryFn,
    required TextEditingController searchValueController,
    required void Function() onSearchFn,
  })  : category = searchCategory,
        value = searchValue,
        onChangeCategory = changeCategoryFn,
        onSearch = onSearchFn,
        controller = searchValueController;

  final String category, value;
  final void Function(String value) onChangeCategory;
  final void Function() onSearch;
  final TextEditingController controller;
  @override
  State<MapHeader> createState() => _MapHeaderState();
}

class _MapHeaderState extends State<MapHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Column(
        spacing: 12,
        children: [
          SearchSection(
            isMapMode: true,
            callback: widget.onSearch,
            controller: widget.controller,
          ),
          RadioButton(
            values: ["전체", "붕어빵", "한식", "일식", "중식", "양식", "카페"],
            selectedValue: widget.category,
            onChange: widget.onChangeCategory,
          ),
        ],
      ),
    );
  }
}
