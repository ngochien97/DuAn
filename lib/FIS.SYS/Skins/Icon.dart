import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FIcon extends StatelessWidget {
  // string icon thông qua static field của class FIcons
  final String icon;
  // màu icon dưới dạng mảng, sử dụng index 0 đối với FFilledIcons và FOutlinedIcons, index 0 và index 1 cho FTwoToneIcons
  final List<Color> color;
  // chiều cao icon, mặc định là 24
  final double size;
  // chiều rộng icon, mặc định là 24
  final Function onPressed;

  const FIcon({
    @required this.icon,
    this.color,
    this.size = 24,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var iconString = icon;
    final isTwoTone = icon.contains('#E6F7FF') || icon.contains('#1890FF');
    if (isTwoTone && color != null && color.length >= 2) {
      iconString = iconString.replaceAll(
          RegExp(r'#E6F7FF'),
          Color(color[0].value)
              .toString()
              .substring(6, 16)
              .replaceFirst('0xff', '#'));
      iconString = iconString.replaceAll(
          RegExp(r'#1890FF'),
          Color(color[1].value)
              .toString()
              .substring(6, 16)
              .replaceFirst('0xff', '#'));
    }

    final Widget svg = SvgPicture.string(
      iconString,
      color: isTwoTone ? null : color == null ? null : color[0],
      height: size,
      width: size,
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(child: svg),
    );
  }
}
