import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class FToolBar extends StatelessWidget {
  final List<FToolBarItem> children;
  final Color backgroundColor;
  FToolBar({@required this.children, this.backgroundColor = FColors.grey1});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.0,
      ),
      color: backgroundColor,
      constraints: BoxConstraints(maxHeight: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}

class FToolBarItem extends StatelessWidget {
  final String icon;
  final Color color;
  final Function onTap;
  final String title;

  FToolBarItem({this.icon, this.title, this.color = FColors.blue6, this.onTap});

  Widget renderItem() {
    if (title == null) {
      return FIconButton(
        icon: icon,
        size: FIconButtonSize.size48,
        backgroundColor: FColors.transparent,
        color: color,
        buttonStyle: FIconButtonStyle.solid,
        onPressed: onTap,
      );
    } else if (icon == null) {
      return FButton(
        title: title,
        size: FButtonSize.size48,
        backgroundColor: FColors.transparent,
        disableBackgroundColor: FColors.transparent,
        disableColor: FColors.grey6,
        color: color,
        buttonStyle: FButtonStyle.solid,
        onPressed: onTap,
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            children: [
              FIcon(
                icon: icon,
                size: 24,
                color: [color, FColors.transparent],
              ),
              FText(
                title,
                style: FTextStyle.titleModules6,
                color: color,
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: renderItem(),
    );
  }
}
