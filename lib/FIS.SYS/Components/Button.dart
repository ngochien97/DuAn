import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final FButtonSize size;
  final FButtonStyle buttonStyle;
  final Color backgroundColor;
  final Color color;
  final String leftIcon;
  final String rightIcon;
  final MaterialTapTargetSize tapTargetSize;
  final bool block;
  final bool isLoading;

  FButton({
    this.title,
    this.onPressed,
    this.size = FButtonSize.size32,
    this.buttonStyle = FButtonStyle.solid,
    this.backgroundColor = FColors.blue6,
    this.color = FColors.grey1,
    this.leftIcon,
    this.rightIcon,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.block = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttonStat;

    switch (size) {
      case FButtonSize.size24:
        buttonStat = {
          "padding": EdgeInsets.symmetric(vertical: 1, horizontal: 16),
          "iconSize": 14.0,
          "borderRadius": 4.0,
          "textStyle": FTextStyle.buttonText2,
        };
        break;
      case FButtonSize.size32:
        buttonStat = {
          "padding": EdgeInsets.symmetric(vertical: 5, horizontal: 24),
          "iconSize": 14.0,
          "borderRadius": 4.0,
          "textStyle": FTextStyle.buttonText2,
        };
        break;
      case FButtonSize.size40:
        buttonStat = {
          "padding": EdgeInsets.symmetric(vertical: 9, horizontal: 32),
          "iconSize": 20.0,
          "borderRadius": 4.0,
          "textStyle": FTextStyle.buttonText2,
        };
        break;
      case FButtonSize.size48:
        buttonStat = {
          "padding": EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          "iconSize": 24.0,
          "borderRadius": 8.0,
          "textStyle": FTextStyle.buttonText1,
        };
        break;
    }

    switch (buttonStyle) {
      case FButtonStyle.solid:
        buttonStat["dashPattern"] = <double>[1, 0];
        buttonStat["borderColor"] = backgroundColor;
        break;
      case FButtonStyle.ghost:
        buttonStat["dashPattern"] = <double>[1, 0];
        break;
      case FButtonStyle.dash:
        buttonStat["dashPattern"] = <double>[2, 2];
        break;
      case FButtonStyle.textAction:
        buttonStat["dashPattern"] = <double>[1, 0];
        buttonStat["borderColor"] = FColors.transparent;
        break;
    }

    return CupertinoButton(
      onPressed: onPressed,
      color: FColors.transparent,
      disabledColor: FColors.transparent,
      borderRadius: BorderRadius.circular(0),
      minSize: tapTargetSize == MaterialTapTargetSize.padded ? 48 : 0,
      padding: EdgeInsets.all(0),
      child: DottedBorder(
        padding: EdgeInsets.all(0.5),
        strokeWidth: 1,
        dashPattern: buttonStat["dashPattern"],
        borderType: BorderType.RRect,
        radius: Radius.circular(buttonStat["borderRadius"]),
        color: onPressed == null ? FColors.grey4 : buttonStat["borderColor"],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonStat["borderRadius"]),
            color: onPressed == null ? FColors.grey4 : backgroundColor,
          ),
          padding: buttonStat["padding"] -
              EdgeInsets.symmetric(
                  horizontal:
                      block ? buttonStat["padding"].horizontal / 2 - 0.5 : 0) -
              EdgeInsets.all(0.5),
          child: Stack(
            overflow: Overflow.visible,
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: isLoading ? 0 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    leftIcon != null
                        ? Container(
                            margin: EdgeInsets.only(right: 4),
                            child: FIcon(
                              icon: leftIcon,
                              color: [
                                onPressed == null ? FColors.grey6 : color
                              ],
                              size: buttonStat["iconSize"],
                            ),
                          )
                        : Container(height: 0, width: 0),
                    title != null
                        ? FText(
                            title,
                            style: buttonStat["textStyle"],
                            color: onPressed == null ? FColors.grey6 : color,
                          )
                        : Container(height: 0, width: 0),
                    rightIcon != null
                        ? Container(
                            margin: EdgeInsets.only(left: 4),
                            child: FIcon(
                              icon: rightIcon,
                              color: [
                                onPressed == null ? FColors.grey6 : color
                              ],
                              size: buttonStat["iconSize"],
                            ),
                          )
                        : Container(height: 0, width: 0),
                  ],
                ),
              ),
              Positioned(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: isLoading ? 1 : 0,
                  child: Container(
                    height: buttonStat["iconSize"],
                    width: buttonStat["iconSize"],
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FButtonSize {
  size24,
  size32,
  size40,
  size48,
}

enum FButtonStyle {
  solid,
  ghost,
  dash,
  textAction,
}
