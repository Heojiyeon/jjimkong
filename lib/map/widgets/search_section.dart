import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/colors.dart';
import 'package:jjimkong/common/widget/button.dart';
import 'package:jjimkong/common/widget/input_field.dart';
import 'package:jjimkong/common/widget/svg_icon.dart';

/// MapHeader 내 검색 영역
class SearchSection extends StatefulWidget {
  final bool isMapMode;
  final void Function() callback;
  final TextEditingController controller;

  const SearchSection({
    super.key,
    required this.isMapMode,
    required this.callback,
    required this.controller,
  });

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  // 검색 버튼을 눌렀을 때 동작하는 메서드
  void _onSearchPressed() {
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!widget.isMapMode)
          Container(
            width: 36,
            color: Colors.white,
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () => Navigator.pop(context),
              icon: SVGIcon(
                svgName: "ic-map",
                iconSize: IconSize.large,
                color: AppColor.secondary,
              ),
            ),
          ),
        SizedBox(
          width: MediaQuery.of(context).size.width -
              124 +
              (widget.isMapMode ? 36 : 0),
          height: 44,
          child: InputField(
            placeholder: "장소명 검색",
            controller: widget.controller,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.search,
            shouldDispose: false,
          ),
        ),
        SizedBox(width: 8),
        Button(
          onPressed: _onSearchPressed,
          backgroundColorState: ButtonBGType.secondary,
          sizeState: ButtonSize.icon,
          icon: SVGIcon(
            svgName: "ic-search",
            iconSize: IconSize.large,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
