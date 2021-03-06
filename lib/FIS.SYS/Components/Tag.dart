import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FTag extends StatelessWidget {
  // content của tag, bắt buộc phải có.
  final String title;
  // size: small, medium, large. Mặc định là medium.
  final FTagSize size;
  // màu nền của tag. Mặc định là grey3.
  final Color backgroundColor;
  // màu của title, icon và border. Mặc định là grey7.
  final Color color;
  // left icon.
  final String leftIcon;
  // right icon.
  final String rightIcon;
  // nếu borderDotted bằng true thì tag có border kiểu dotted.
  final bool dottedBorder;
  final Function onPressed;

  FTag({
    @required this.title,
    this.size = FTagSize.small,
    this.color = FColors.grey7,
    this.backgroundColor = FColors.grey3,
    this.leftIcon,
    this.rightIcon,
    this.dottedBorder = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> tagState;
    switch (size) {
      case FTagSize.small:
        tagState = {
          'borderRadius': 20.0,
          'paddingVertical': 4.0,
          'paddingHorizontal': 8.0,
          'iconSize': 12.0,
          'textSize': FTextStyle.subtitle2,
        };
        break;
      case FTagSize.medium:
        tagState = {
          'borderRadius': 24.0,
          'paddingVertical': 8.0,
          'paddingHorizontal': 16.0,
          'iconSize': 14.0,
          'textSize': FTextStyle.subtitle2,
        };
        break;
      case FTagSize.large:
        tagState = {
          'borderRadius': 32.0,
          'paddingVertical': 9.0,
          'paddingHorizontal': 23.5,
          'iconSize': 20.0,
          'textSize': FTextStyle.buttonText2,
        };
        break;
    }

    double border = tagState['borderRadius'];
    return dottedBorder == true
        ? Container(
            margin: EdgeInsets.all(0.5),
            child: DottedBorder(
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: Radius.circular(border),
                color: color,
                padding: EdgeInsets.all(0.5),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      leftIcon != null
                          ? Container(
                              margin: EdgeInsets.only(right: 4.0),
                              child: FIcon(
                                icon: leftIcon,
                                size: tagState['iconSize'],
                                color: [color, FColors.transparent],
                              ),
                            )
                          : SizedBox(),
                      FText(
                        title,
                        style: tagState['textSize'],
                        color: color,
                      ),
                      rightIcon != null
                          ? GestureDetector(
                              onTap: onPressed,
                              child: Container(
                                margin: EdgeInsets.only(left: 4.0),
                                child: FIcon(
                                  icon: rightIcon,
                                  size: tagState['iconSize'],
                                  color: [color, FColors.transparent],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: tagState['paddingHorizontal'] - 0.5,
                    vertical: tagState['paddingVertical'] - 0.5,
                  ),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(border)),
                )),
          )
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                leftIcon != null
                    ? Container(
                        margin: EdgeInsets.only(right: 4.0),
                        child: FIcon(
                          icon: leftIcon,
                          size: tagState['iconSize'],
                          color: [color, FColors.transparent],
                        ),
                      )
                    : SizedBox(),
                FText(
                  title,
                  style: tagState['textSize'],
                  color: color,
                ),
                rightIcon != null
                    ? GestureDetector(
                        onTap: onPressed,
                        child: FIcon(
                          icon: rightIcon,
                          size: tagState['iconSize'],
                          color: [color, FColors.transparent],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: tagState['paddingHorizontal'],
              vertical: tagState['paddingVertical'],
            ),
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(width: 1, color: color),
                borderRadius: BorderRadius.circular(border)),
          );
  }
}

enum FTagSize {
  small,
  medium,
  large,
}
