import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class FSnackBar {
  final FText content;
  final int duration;
  final double borderRadius;
  final String actionLabel;
  final Function onPressed;
  final bool isFloating;
  final FIcon icon;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> key;

  FSnackBar(
      {@required this.key,
      this.borderRadius = 0,
      this.duration = 3,
      @required this.content,
      this.actionLabel,
      this.icon,
      this.backgroundColor = FColors.grey9,
      this.isFloating = false,
      this.onPressed});

  static showSnackBar(BuildContext context, FSnackBar snackBar) {
    final _snackBar = SnackBar(
      elevation: 0,
      behavior: snackBar.isFloating == true ? SnackBarBehavior.floating : null,
      duration: Duration(seconds: snackBar.duration),
      backgroundColor: snackBar.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(snackBar.borderRadius),
      ),
      content: Container(
        child: Wrap(
          children: [
            snackBar.icon != null
                ? FBoundingBox(
                    child: snackBar.icon,
                    type: FBoundingBoxType.circle,
                    backgroundColor: FColors.transparent,
                  )
                : Container(),
            Container(
                margin: EdgeInsets.only(left: 8), child: snackBar.content),
          ],
        ),
      ),
      action: snackBar.actionLabel != null
          ? SnackBarAction(
              label: snackBar.actionLabel,
              onPressed: snackBar.onPressed,
              textColor: FColors.blue6,
            )
          : null,
    );
    snackBar.key.currentState.showSnackBar(_snackBar);
  }
}
