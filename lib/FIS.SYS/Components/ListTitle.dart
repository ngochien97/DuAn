import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/Divider.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Effect.dart';
import 'package:flutter/material.dart';

class FListTitle extends StatelessWidget {
  final FText title;
  final FBoundingBox avatar;
  final FText subtitle;
  final List<Widget> action;
  final bool dividerIndent;
  final bool round;
  final double height;
  final Color backgroundColor;

  const FListTitle({
    Key key,
    this.title,
    this.avatar,
    this.subtitle,
    this.action,
    this.dividerIndent = false,
    this.round = true,
    this.height,
    this.backgroundColor = FColors.grey1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(0),
          color: FColors.transparent,
          elevation: 0,
          shape: round == true
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Container(
            height: height,
            decoration: round == true
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: backgroundColor,
                    boxShadow: [FEffect.elevation2],
                  )
                : null,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                avatar != null
                    ? Container(
                        margin: EdgeInsets.only(
                          right: 12,
                        ),
                        child: avatar,
                      )
                    : Container(),
                title != null
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: subtitle != null ? 12 : 13,
                                bottom: subtitle != null
                                    ? 0
                                    : round == false ? 12 : 13,
                              ),
                              child: title,
                            ),
                            subtitle != null
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: 2,
                                        bottom: round == false ? 11 : 12),
                                    child: subtitle,
                                  )
                                : Container()
                          ],
                        ),
                      )
                    : Container(),
                action != null
                    ? Container(
                        child: Row(
                          children: action,
                        ),
                        margin: EdgeInsets.only(left: 8),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        round == false
            ? FDivider(
                indent: dividerIndent == true ? 28 : 0,
              )
            : Container()
      ],
    );
  }
}
