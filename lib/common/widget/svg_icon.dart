import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum IconSize { xsmall, small, medium, large, xlarge }

// 아이콘 사이즈 varient
class SVGIconStyles {
  static const Map<IconSize, double> iconSize = {
    IconSize.xsmall: 14.0,
    IconSize.small: 16.0,
    IconSize.medium: 24.0,
    IconSize.large: 28.0,
    IconSize.xlarge: 32.0
  };
}

///
/// 아이콘 컴포넌트
///
/// [svgName] 파일명
/// [iconSize] 아이콘 사이즈 / small, medium
/// [color] 아이콘 설정 색상
///
///
class SVGIcon extends StatelessWidget {
  const SVGIcon({
    super.key,
    required this.svgName,
    required this.iconSize,
    this.color,
  });

  final String svgName;
  final IconSize iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return (SvgPicture.asset(
      'assets/images/$svgName.svg', // SVG 경로
      width: SVGIconStyles.iconSize[iconSize],
      height: SVGIconStyles.iconSize[iconSize],
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    ));
  }
}
