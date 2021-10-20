import 'dart:ui';

import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

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

  FState({
    Key key,
    this.noticeText,
    this.subtitleText,
    @required this.picture,
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                        size: FIconButtonSize.size32,
                        onPressed: () => Navigator.pop(context),
                        color: FColors.grey10,
                        buttonStyle: FIconButtonStyle.solid,
                        backgroundColor: FColors.grey1,
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    24, MediaQuery.of(context).size.height * 0.10, 24, 0),
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
                              color: FColors.grey1,
                              buttonStyle: FButtonStyle.solid,
                              backgroundColor: FColors.blue6,
                              tapTargetSize: MaterialTapTargetSize.padded,
                              block: true,
                            )
                          : Container(),
                      // Expanded(
                      //   child: widget.bottomItems != null
                      //       ? Container(
                      //           child: widget.bottomItems,
                      //         )
                      //       : Container(),
                      // ),
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
}

enum ImageType {
  svgPicture,
  image,
}
