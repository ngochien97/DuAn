import 'package:Framework/FIS.SYS/Components/Button.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FPopupActionSheet extends StatelessWidget {
  final Widget child;
  final List<FPopupAction> actions;
  final String message;
  final Color messageColor;

  FPopupActionSheet(
      {this.child,
      this.actions,
      this.message,
      this.messageColor = FColors.grey7});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: FColors.transparent,
            context: context,
            builder: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      message != null
                          ? Container(
                              margin: EdgeInsets.only(
                                bottom: 12.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              child: FText(
                                message,
                                color: messageColor,
                                style: FTextStyle.bodyText2,
                              ))
                          : SizedBox(),
                      Column(
                        children: actions,
                      ),
                    ],
                  ),
                ));
      },
      child: child,
    );
  }
}

class FPopupAction extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color backgroundColor;
  final Color color;

  FPopupAction(
      {this.backgroundColor = FColors.grey1,
      this.color = FColors.blue6,
      this.onPressed,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12.0,
        left: 16.0,
        right: 16.0,
      ),
      child: FButton(
        title: title,
        backgroundColor: backgroundColor,
        color: color,
        size: FButtonSize.size48,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        block: true,
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
