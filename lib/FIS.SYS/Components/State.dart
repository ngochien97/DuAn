import 'dart:ui';

import 'package:flutter/material.dart';
import '../../F.Utils/SrceenExtensions.dart';

import '../Skins/Typography.dart';
import '../Styles/Colors.dart';
import '../Styles/Icons.dart';
import '../Styles/Spacer.dart';
import 'ComponentsBase.dart';

class FState extends StatefulWidget {
  final String noticeText;
  final String subtitleText;
  final String buttonTitle;
  final FTextStyle noticeTextStyle;
  final FTextStyle subtitleTextStyte;
  final Widget picture;
  final bool button;
  final bool iconButton;
  final Function onPressButtonEvent;
  final Color backgroundColor;

  const FState({
    @required this.picture,
    Key key,
    this.noticeText,
    this.subtitleText,
    this.onPressButtonEvent,
    this.button = true,
    this.noticeTextStyle = FTextStyle.titleModules3,
    this.subtitleTextStyte = FTextStyle.bodyText2,
    this.iconButton = true,
    this.backgroundColor,
    this.buttonTitle = 'Action button',
  }) : super(key: key);
  @override
  _FState createState() => _FState();
}

class _FState extends State<FState> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            color: widget.backgroundColor,
            child: Column(
              children: [
                widget.iconButton
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: FIconButton(
                          icon: FOutlinedIcons.close,
                          onPressed: () => Navigator.pop(context),
                          color: FColors.grey10,
                          backgroundColor: FColors.grey1,
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.fromLTRB(24, 92.h, 24, 0),
                  child: Center(
                    child: Column(
                      children: [
                        FBoundingBox(
                          size: FBoxSize.auto_square,
                          child: widget.picture,
                        ),
                        FSpacer.space48px,
                        widget.noticeText != null
                            ? FText(
                                widget.noticeText,
                                style: widget.noticeTextStyle,
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                        FSpacer.space4px,
                        widget.subtitleText != null
                            ? FText(
                                widget.subtitleText,
                                style: widget.subtitleTextStyte,
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                        FSpacer.space24px,
                        widget.button
                            ? FButton(
                                title: widget.buttonTitle,
                                size: FButtonSize.size48,
                                onPressed: widget.onPressButtonEvent,
                                block: true,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
