import 'package:flutter/material.dart';

import '../Skins/Icon.dart';
import '../Skins/Typography.dart';
import '../Styles/Colors.dart';
import 'ComponentsBase.dart';

class FToolBar extends StatelessWidget {
  final List<FToolBarItem> children;
  final Color backgroundColor;
  const FToolBar(
      {@required this.children, this.backgroundColor = FColors.grey1});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 1.0,
        ),
        color: backgroundColor,
        constraints: const BoxConstraints(maxHeight: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );
}

class FToolBarItem extends StatelessWidget {
  final String icon;
  final Color color;
  final Function onTap;
  final String title;

  const FToolBarItem(
      {this.icon, this.title, this.color = FColors.blue6, this.onTap});

  Widget renderItem() {
    if (title == null) {
      return FIconButton(
        icon: icon,
        size: FIconButtonSize.size48,
        backgroundColor: FColors.transparent,
        color: color,
        onPressed: onTap,
      );
    } else if (icon == null) {
      return FButton(
        title: title,
        size: FButtonSize.size48,
        backgroundColor: FColors.transparent,
        disableBackgroundColor: FColors.transparent,
        color: color,
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
  Widget build(BuildContext context) => Container(
        child: renderItem(),
      );
}