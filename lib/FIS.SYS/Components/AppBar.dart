import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Widget headerLead;
  final Widget headerCenter;
  final List<Widget> headerActions;
  final FText bodyTitle;
  final FBoundingBox avatar;
  final FTextField bottom;
  final FButton bottomAction;
  final bool rightAvatar;

  FAppBar({
    Key key,
    this.headerLead,
    this.headerCenter,
    this.bodyTitle,
    this.avatar,
    this.bottom,
    this.rightAvatar = false,
    this.headerActions = const [],
    this.bottomAction,
    this.backgroundColor = FColors.grey1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              hasHeader
                  ? Container(
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          headerLead != null
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  child: headerLead)
                              : Container(),
                          Expanded(
                            child: headerCenter != null
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 0.13 * size.width,
                                        right: 0.15 * size.width -
                                            (headerActions != null
                                                ? (headerActions.length - 1) *
                                                    48.0
                                                : 0.0)),
                                    child: headerCenter)
                                : Container(),
                          ),
                          for (var widget in headerActions) widget
                        ],
                      ),
                    )
                  : Container(),
              hasBody
                  ? Container(
                      margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                      height: 40,
                      child: Row(
                        children: [
                          !rightAvatar
                              ? Container()
                              : avatar != null
                                  ? Container(
                                      margin: EdgeInsets.only(right: 12.0),
                                      child: avatar)
                                  : Container(),
                          Expanded(
                            child: bodyTitle != null ? bodyTitle : Container(),
                          ),
                          !rightAvatar ? avatar : Container()
                        ],
                      ),
                    )
                  : Container(),
              hasBottom
                  ? Container(
                      margin: EdgeInsets.only(
                          top: calculateHeight == 48 ? 0 : 4,
                          left: 16,
                          right: 16),
                      height: 40,
                      child: Row(
                        children: [
                          bottom != null
                              ? Expanded(child: bottom)
                              : Container(),
                          bottomAction != null
                              ? Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: bottomAction,
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(calculateHeight);

  double get calculateHeight {
    double height = 0;
    if (hasHeader) {
      height += 48;
    }
    if (hasBody) {
      height += 68;
    }
    if (hasBottom) {
      height += 32;
      if (!hasBody) {
        height += 20;
      }
      if (!hasHeader) {
        height -= 4;
      }
    }

    return height;
  }

  bool get hasHeader =>
      headerActions.length > 0 || headerCenter != null || headerLead != null;
  bool get hasBody => bodyTitle != null || avatar != null;
  bool get hasBottom => bottom != null || bottomAction != null;
}
