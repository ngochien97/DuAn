import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FTabBar extends StatefulWidget {
  final List<FTabBarItem> children;
  final Color backgroundColor;
  final int currentIndex;
  final Color selectedColor;
  final FFloatingButtonAction floatingButtonAction;
  final FFloatingButtonActionPosition floatingButtonActionPosition;
  final double elevation;
  final double height;

  FTabBar(
      {@required this.children,
      this.floatingButtonAction,
      this.backgroundColor = FColors.grey1,
      this.currentIndex,
      this.elevation = 0,
      this.height = 51.0,
      this.selectedColor = FColors.blue6,
      this.floatingButtonActionPosition = FFloatingButtonActionPosition.start});
  @override
  _FTabBarState createState() => _FTabBarState();
}

class _FTabBarState extends State<FTabBar> {
  String checkPosition;
  Widget renderWithFloatingButton() {
    var length = widget.children.length;
    var end = (length / 2).round();
    var position = widget.floatingButtonActionPosition;
    switch (position) {
      case FFloatingButtonActionPosition.start:
        setState(() {
          checkPosition = 'start';
        });
        break;
      case FFloatingButtonActionPosition.center:
        if (widget.children.length % 2 == 0) {
          setState(() {
            checkPosition = 'center';
          });
        } else {
          setState(() {
            checkPosition = 'start';
          });
        }
        break;
      case FFloatingButtonActionPosition.end:
        setState(() {
          checkPosition = 'end';
        });
        break;
      default:
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        checkPosition == 'start'
            ? Container(child: widget.floatingButtonAction)
            : SizedBox(),
        for (var element in widget.children.sublist(0, end))
          FTabBarItem(
            icon: element.icon,
            backgroundColor: element.backgroundColor,
            color: widget.currentIndex == widget.children.indexOf(element)
                ? widget.selectedColor
                : element.color,
            title: element.title,
            notify: element.notify,
            onTap: () {
              var index = widget.children.indexOf(element);
              element.onTap(index);
            },
          ),
        checkPosition == 'center'
            ? Container(child: widget.floatingButtonAction)
            : SizedBox(),
        for (var element in widget.children.sublist(end))
          FTabBarItem(
            icon: element.icon,
            backgroundColor: element.backgroundColor,
            color: widget.currentIndex == widget.children.indexOf(element)
                ? widget.selectedColor
                : element.color,
            title: element.title,
            notify: element.notify,
            onTap: () {
              var index = widget.children.indexOf(element);
              element.onTap(index);
            },
          ),
        checkPosition == 'end'
            ? Container(child: widget.floatingButtonAction)
            : SizedBox(),
      ],
    );
  }

  Widget renderWithoutFloatingButton() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var element in widget.children)
            FTabBarItem(
              icon: element.icon,
              backgroundColor: element.backgroundColor,
              color: widget.currentIndex == widget.children.indexOf(element)
                  ? widget.selectedColor
                  : element.color,
              title: element.title,
              notify: element.notify,
              onTap: () {
                var index = widget.children.indexOf(element);
                element.onTap(index);
              },
            )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: widget.backgroundColor,
      elevation: widget.elevation,
      child: Container(
          height: widget.height,
          margin: EdgeInsets.symmetric(vertical: 1.0),
          child: widget.floatingButtonAction != null
              ? renderWithFloatingButton()
              : renderWithoutFloatingButton()),
    );
  }
}

class FTabBarItem extends StatelessWidget {
  final String icon;
  final String title;
  final Color backgroundColor;
  final Color color;
  final Function onTap;
  final FBoundingBox notify;

  FTabBarItem({
    @required this.icon,
    this.title,
    this.color = FColors.grey6,
    this.backgroundColor = FColors.transparent,
    this.onTap,
    this.notify,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: EdgeInsets.only(left: 21.0, right: 21.0, top: 6.0),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FIcon(
                    icon: icon,
                    size: 24.0,
                    color: [
                      color,
                      FColors.transparent,
                    ],
                  ),
                  title != null
                      ? FText(
                          title,
                          color: color,
                          style: FTextStyle.tabbar,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Positioned(
                left: 14.0,
                top: title != null ? -3.0 : 3.0,
                child: notify != null ? notify : SizedBox())
          ],
        ),
      ),
    );
  }
}

class FFloatingButtonAction extends StatelessWidget {
  final String icon;
  final Function onPressed;
  final Color backgroundColor;
  final Color color;
  final Widget action;

  FFloatingButtonAction(
      {this.icon,
      this.action,
      this.backgroundColor = FColors.blue6,
      this.color = FColors.grey1,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 64,
        width: 64,
        color: FColors.transparent,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
                bottom: 2,
                child: FBoundingBox(
                  child: action != null
                      ? action
                      : FIcon(
                          icon: icon,
                          color: [color, FColors.transparent],
                          size: 24,
                        ),
                  backgroundColor: backgroundColor,
                  size: FBoxSize.size64x64,
                  type: FBoundingBoxType.circle,
                ))
          ],
        ),
      ),
    );
  }
}

enum FFloatingButtonActionPosition { start, center, end }
