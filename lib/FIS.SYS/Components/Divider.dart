import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FDivider extends StatelessWidget {
  final bool vertical;
  final double height;
  final double space;
  final Color color;
  final double indent;
  final double endIndent;
  final double thickness;
  FDivider(
      {this.color = FColors.grey4,
      this.endIndent = 0.0,
      this.space = 0.0,
      this.indent = 0.0,
      this.thickness = 1.0,
      this.height = 100.0,
      this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return vertical == true
        ? Container(
            height: height,
            child: VerticalDivider(
              width: space,
              thickness: thickness,
              color: color,
              indent: indent,
              endIndent: endIndent,
            ),
          )
        : Divider(
            height: space,
            thickness: thickness,
            color: color,
            indent: indent,
            endIndent: endIndent,
          );
  }
}
