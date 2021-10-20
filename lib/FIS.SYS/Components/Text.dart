import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:flutter/material.dart';

class FText extends StatelessWidget {
  final String value;
  final int maxLines;
  final TextAlign textAlign;
  final FTextStyle style;
  final Color color;
  final TextOverflow overflow;
  final bool softWrap;
  final double textScaleFactor;
  final TextWidthBasis textWidthBasis;
  final TextDecoration decoration;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final String fontFamily;

  FText(
    this.value, {
    Key key,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.style = FTextStyle.bodyText2,
    this.color,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.textWidthBasis,
    this.decoration,
    this.fontWeight,
    this.backgroundColor,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: textAlign,
      style: style.textStyle.copyWith(
        color: color,
        decoration: decoration,
        fontWeight: fontWeight,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
      ),
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
