import 'package:flutter/material.dart';

import '../Styles/StyleBase.dart';
import 'BoundingBox.dart';
import 'ComponentsBase.dart';

class FCard extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget content;
  final List<Widget> actionChildren;
  final Widget avatar;
  final Widget topItems;
  final Widget bottomItems;
  final CrossAxisAlignment alignment;
  final FBoxSize size;
  final FBoundingBoxType type;
  final EdgeInsets padding;
  final bool hasShadow;
  final Color backgroundColor;
  final Function onTap;
  final Function onLongPress;

  const FCard({
    Key key,
    this.title,
    this.subtitle,
    this.content,
    this.actionChildren,
    this.avatar,
    this.alignment = CrossAxisAlignment.start,
    this.size = FBoxSize.auto_square,
    this.padding,
    this.type = FBoundingBoxType.circle,
    this.backgroundColor = FColors.grey1,
    this.hasShadow = true,
    this.topItems,
    this.bottomItems,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: backgroundColor,
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: backgroundColor,
              boxShadow: hasShadow ? [FEffect.elevation2] : null,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                GestureDetector(
                  onTap: onTap,
                  onLongPress: onLongPress,
                  child: Column(
                    crossAxisAlignment: alignment,
                    children: [
                      avatar != null
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: FBoundingBox(
                                size: size,
                                type: type,
                                topItems: topItems,
                                bottomItems: bottomItems,
                                child: avatar,
                              ),
                            )
                          : Container(),
                      title != null
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              child: title,
                            )
                          : Container(),
                      subtitle != null
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: subtitle,
                            )
                          : Container(),
                      content != null
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: content,
                            )
                          : Container(),
                    ],
                  ),
                ),
                actionChildren != null
                    ? Container(
                        child: Wrap(children: actionChildren),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
}
