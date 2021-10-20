import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class FTab extends StatelessWidget {
  final String icon;

  final String title;

  final Color backgroundColor;

  final Color color;

  final bool select;

  const FTab(
      {Key key,
      this.icon,
      this.title,
      this.backgroundColor,
      this.color,
      this.select = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 138,
      decoration: BoxDecoration(
          color: FColors.grey1,
          border: select != null
              ? Border(
                  bottom: BorderSide(
                      color: select == false ? FColors.grey1 : FColors.blue6,
                      width: 2.0))
              : null),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon == null
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.only(right: 4),
                    child: FIcon(
                      icon: icon,
                      size: 16,
                      color: [
                        select == true ? color : FColors.grey7,
                        backgroundColor
                      ],
                    ),
                  ),
            title == null
                ? SizedBox(
                    width: 1.0,
                  )
                : FText(
                    title,
                    style: FTextStyle.titleModules4,
                    color: select == true ? color : FColors.grey7,
                  ),
          ],
        ),
      ),
    );
  }
}
