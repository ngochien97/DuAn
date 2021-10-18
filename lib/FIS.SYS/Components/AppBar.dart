import 'package:flutter/material.dart';

import '../Styles/StyleBase.dart';
import 'ComponentsBase.dart';

class FAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Widget headerLead;
  final Widget headerCenter;
  final List<Widget> headerActions;
  final FText bodyTitle;
  final FBoundingBox avatar;
  final Widget bottom;
  final Widget bottomAction;
  final Brightness brightness;

  const FAppBar({
    Key key,
    this.headerLead,
    this.headerCenter,
    this.bodyTitle,
    this.avatar,
    this.bottom,
    this.headerActions = const [],
    this.bottomAction,
    this.backgroundColor = FColors.grey1,
    this.brightness = Brightness.light,
  }) : super(key: key);

  bool get hasHeader =>
      headerActions.isNotEmpty || headerCenter != null || headerLead != null;
  bool get hasBody => bodyTitle != null || avatar != null;
  bool get hasBottom => bottom != null || bottomAction != null;

  @override
  Size get preferredSize => Size.fromHeight(calculateHeight);

  double get calculateHeight {
    var height = 0.0;
    if (hasHeader) {
      height += 48.0;
    }
    if (hasBody) {
      height += 68.0;
    }
    if (hasBottom) {
      height += 32.0;
      if (!hasBody) {
        height += 20.0;
      }
      if (!hasHeader) {
        height -= 4.0;
      }
    }

    return height;
  }

  @override
  _FAppBarState createState() => _FAppBarState();
}

class _FAppBarState extends State<FAppBar> {
  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: FColors.transparent,
        elevation: 0,
        brightness: widget.brightness,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          color: widget.backgroundColor,
          child: SafeArea(
            child: Container(
              color: widget.backgroundColor,
              child: Column(
                children: [
                  widget.hasHeader
                      ? Container(
                          height: 48,
                          child: Row(
                            children: [
                              widget.headerLead != null
                                  ? Container(
                                      // margin: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: widget.headerLead)
                                  : Container(),
                              Expanded(
                                child: widget.headerCenter != null
                                    ? Container(
                                        // margin: EdgeInsets.only(
                                        //     left: 0.13 * size.width,
                                        //     right: 0.15 * size.width -
                                        //         (widget.headerActions != null
                                        //             ? (widget.headerActions.length -
                                        //                     1) *
                                        //                 48.0
                                        //             : 0.0)),
                                        child: widget.headerCenter)
                                    : Container(),
                              ),
                              for (var widget in widget.headerActions) widget
                            ],
                          ),
                        )
                      : Container(),
                  widget.hasBody
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 8, left: 16, right: 16),
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: widget.bodyTitle ?? Container(),
                              ),
                              widget.avatar == null
                                  ? Container()
                                  : widget.avatar != null
                                      ? Container(child: widget.avatar)
                                      : Container(),
                            ],
                          ),
                        )
                      : Container(),
                  widget.hasBottom
                      ? Container(
                          margin: EdgeInsets.only(
                            top: widget.calculateHeight == 48 ? 0 : 4,
                          ),
                          height: 48,
                          child: Row(
                            children: [
                              widget.bottom != null
                                  ? Expanded(child: widget.bottom)
                                  : Container(),
                              widget.bottomAction != null
                                  ? Container(
                                      child: widget.bottomAction,
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
        ),
      );
}
