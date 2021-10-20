import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/Checkbox.dart';
import 'package:Framework/FIS.SYS/Components/Divider.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Effect.dart';
import 'package:flutter/material.dart';

class FListTitle extends StatelessWidget {
  final FText title;
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
  final Widget titleItem;
  final List<Widget> bottomAction;
  final bool hasPadding;
  final bool hasShadow;

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
    this.bottomAction,
    this.hasPadding = true,
    this.hasShadow = true,
    this.titleItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
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
              decoration: BoxDecoration(
                borderRadius: round == true ? BorderRadius.circular(8.0) : null,
                color: backgroundColor,
                boxShadow: hasShadow ? [FEffect.elevation2] : null,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  isSelect ? startItem : Container(),
                  avatar != null
                      ? Container(
                          margin: hasPadding
                              ? EdgeInsets.fromLTRB(0, 12, 12, 12)
                              : EdgeInsets.only(
                                  right: 12,
                                ),
                          child: avatar,
                        )
                      : Container(),
                  titleItem != null
                      ? Container(
                          child: titleItem,
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
                                      : round == false
                                          ? 12
                                          : 13,
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
                                  : Container(),
                              bottomAction != null
                                  ? Container(
                                      child: Row(
                                        children: bottomAction,
                                      ),
                                      margin: EdgeInsets.only(bottom: 8),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container(),
                  action != null && !isSelect
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
          // round == false
          //     ? FDivider(
          //         indent: dividerIndent == true ? 28 : 0,
          //       )
          //     : Container()
        ],
      ),
    );
  }
}
