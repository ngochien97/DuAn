import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FSnackBar {
  final Duration duration;
  final Duration animationDuration;
  final Color backgroundColor;
  final FIcon icon;
  final Function onTap;
  final Widget action;
  final FText message;
  final double borderRadius;
  final EdgeInsets margin;
  final FlushbarPosition position;
  final FlushbarDismissDirection dismissDirection;

  FSnackBar({
    this.duration,
    this.animationDuration,
    this.backgroundColor,
    this.icon,
    this.onTap,
    this.action,
    this.message,
    this.borderRadius,
    this.margin,
    this.position = FlushbarPosition.BOTTOM,
    this.dismissDirection = FlushbarDismissDirection.VERTICAL,
  });
}

Flushbar showFSnackBar(BuildContext context, FSnackBar snackBar) => Flushbar(
      animationDuration: snackBar.animationDuration != null
          ? snackBar.animationDuration
          : Duration(milliseconds: 800),
      duration: snackBar.duration != null
          ? snackBar.duration
          : Duration(seconds: 1, milliseconds: 500),
      padding: EdgeInsets.all(0),
      borderRadius: snackBar.borderRadius,
      flushbarPosition: snackBar.position,
      dismissDirection: snackBar.dismissDirection,
      margin: snackBar.margin,
      messageText: FListTitle(
        avatar: FBoundingBox(
          child: snackBar.icon,
          backgroundColor: FColors.transparent,
          type: FBoundingBoxType.circle,
          size: FBoxSize.size24x24,
        ),
        backgroundColor: snackBar.backgroundColor,
        onTap: snackBar.onTap,
        action: snackBar.action != null ? [snackBar.action] : null,
        title: snackBar.message,
      ),
    )..show(context);
