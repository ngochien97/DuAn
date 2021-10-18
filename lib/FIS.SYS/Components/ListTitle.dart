import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import '../Styles/Effect.dart';
import 'BoundingBox.dart';
import 'Divider.dart';

class FListTitle extends StatelessWidget {
  final Widget title;
  final FBoundingBox avatar;
  final Widget subtitle;
  final List<Widget> action;
  final bool dividerIndent;
  final bool round;
  final bool isSelect;
  final double height;
  final Color backgroundColor;
  final Function onTap;
  final Function onLongPress;
  final Widget startItem;

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
    this.onTap,
    this.isSelect = false,
    this.startItem,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(0),
              color: FColors.transparent,
              elevation: 0,
              shape: round == true
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  : null,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  borderRadius:
                      round == true ? BorderRadius.circular(8.0) : null,
                  color: backgroundColor,
                  boxShadow: [FEffect.elevation2],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    isSelect ? startItem : Container(),
                    avatar != null
                        ? Container(
                            margin: const EdgeInsets.only(
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
                                  width: double.infinity,
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
                    action != null && !isSelect
                        ? Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: action,
                            ),
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
        ),
      );
}
