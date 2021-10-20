import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Styles/Typographies.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';

enum FTextStyle {
  largeTitle1,
  largeTitle2,
  titleModules1,
  titleModules2,
  titleModules3,
  titleModules4,
  titleModules5,
  titleModules6,
  bodyText1,
  bodyText2,
  buttonText1,
  buttonText2,
  subtitle1,
  subtitle2,
  tabbar,
  overline,
}

extension FTextStyleExtension on FTextStyle {
  static Map<FTextStyle, TextStyle> fTextStyleValue = {
    FTextStyle.largeTitle1: CustomFont.semibold38_46.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.largeTitle2: CustomFont.semibold30_38.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules1: CustomFont.semibold24_32.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules2: CustomFont.semibold20_28.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules3: CustomFont.semibold16_24.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules4: CustomFont.regular16_24.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules5: CustomFont.semibold14_22.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.titleModules6: CustomFont.regular14_22.copyWith(
      color: FColors.grey9,
    ),
    FTextStyle.bodyText1: CustomFont.regular16_24.copyWith(
      color: FColors.grey8,
    ),
    FTextStyle.bodyText2: CustomFont.regular14_22.copyWith(
      color: FColors.grey8,
    ),
    FTextStyle.buttonText1: CustomFont.semibold16_24.copyWith(),
    FTextStyle.buttonText2: CustomFont.regular14_22.copyWith(),
    FTextStyle.subtitle1: CustomFont.regular14_22.copyWith(
      color: FColors.grey7,
    ),
    FTextStyle.subtitle2: CustomFont.regular12_16.copyWith(
      color: FColors.grey7,
    ),
    FTextStyle.tabbar: CustomFont.regular10_18.copyWith(
      color: FColors.grey7,
    ),
    FTextStyle.overline: CustomFont.regular10_18.copyWith(
      color: FColors.grey6,
    ),
  };
  TextStyle get textStyle => fTextStyleValue[this];
}
