import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

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
  final bool hasPadding;
  final bool hasShadow;
  final Color backgroundColor;
  final Function onTap;
  final Function onLongPress;

  FCard({
    Key key,
    this.title,
    this.subtitle,
    this.content,
    this.actionChildren,
    this.avatar,
    this.alignment = CrossAxisAlignment.start,
    this.size = FBoxSize.auto_square,
    this.hasPadding = true,
    this.type = FBoundingBoxType.circle,
    this.backgroundColor = FColors.grey1,
    this.hasShadow = true,
    this.topItems,
    this.bottomItems,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: backgroundColor,
        child: Container(
          padding: hasPadding ? EdgeInsets.all(16) : EdgeInsets.all(0),
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
                            margin: EdgeInsets.only(bottom: 8),
                            child: FBoundingBox(
                              child: avatar,
                              size: size,
                              type: type,
                              topItems: topItems,
                              bottomItems: bottomItems,
                            ),
                          )
                        : Container(),
                    title != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: title,
                          )
                        : Container(),
                    subtitle != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: subtitle,
                          )
                        : Container(),
                    content != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8),
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
}
