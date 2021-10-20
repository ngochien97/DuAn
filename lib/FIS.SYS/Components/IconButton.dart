import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FIconButton extends StatelessWidget {
  final Function onPressed;
  final FIconButtonSize size;
  final FIconButtonStyle buttonStyle;
  final Color backgroundColor;
  final Color color;
  final String icon;
  final MaterialTapTargetSize tapTargetSize;

  FIconButton({
    Key key,
    this.onPressed,
    @required this.icon,
    this.color = FColors.grey1,
    this.size = FIconButtonSize.size32,
    this.backgroundColor = FColors.blue6,
    this.buttonStyle = FIconButtonStyle.solid,
    this.tapTargetSize = MaterialTapTargetSize.padded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttonStat;

    switch (size) {
      case FIconButtonSize.size24:
        buttonStat = {
          "padding": EdgeInsets.all(4),
          "borderRadius": 24.0,
          "iconSize": 16.0
        };
        break;
      case FIconButtonSize.size32:
        buttonStat = {
          "padding": EdgeInsets.all(7),
          "borderRadius": 24.0,
          "iconSize": 18.0,
        };
        break;
      case FIconButtonSize.size40:
        buttonStat = {
          "padding": EdgeInsets.all(10),
          "borderRadius": 24.0,
          "iconSize": 20.0,
        };
        break;
      case FIconButtonSize.size48:
        buttonStat = {
          "padding": EdgeInsets.all(12),
          "borderRadius": 24.0,
          "iconSize": 24.0,
        };
        break;
    }

    switch (buttonStyle) {
      case FIconButtonStyle.solid:
        buttonStat["dashPattern"] = <double>[1, 0];
        buttonStat["borderColor"] = backgroundColor;
        break;
      case FIconButtonStyle.ghost:
        buttonStat["dashPattern"] = <double>[1, 0];
        buttonStat["borderColor"] = color;
        break;
      case FIconButtonStyle.dash:
        buttonStat["dashPattern"] = <double>[2, 2];
        buttonStat["borderColor"] = color;
        break;
      case FIconButtonStyle.iconAction:
        buttonStat["dashPattern"] = <double>[1, 0];
        buttonStat["borderColor"] = FColors.transparent;
        break;
    }

    return CupertinoButton(
      disabledColor: FColors.transparent,
      onPressed: onPressed,
      color: FColors.transparent,
      borderRadius: BorderRadius.circular(0),
      minSize: tapTargetSize == MaterialTapTargetSize.padded ? 48 : 0,
      padding: EdgeInsets.all(0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(buttonStat["borderRadius"]),
        padding: EdgeInsets.all(0.5),
        strokeWidth: 1,
        dashPattern: buttonStat["dashPattern"],
        color: buttonStat["borderColor"],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonStat["borderRadius"]),
            color: onPressed == null ? FColors.grey4 : backgroundColor,
          ),
          padding: buttonStat["padding"] - EdgeInsets.all(0.5),
          child: Container(
            child: FIcon(
              icon: icon,
              color: [onPressed == null ? FColors.grey6 : color],
              size: buttonStat["iconSize"],
            ),
          ),
        ),
      ),
    );
  }
}

enum FIconButtonSize {
  size24,
  size32,
  size40,
  size48,
}

enum FIconButtonStyle {
  solid,
  ghost,
  dash,
  iconAction,
}
