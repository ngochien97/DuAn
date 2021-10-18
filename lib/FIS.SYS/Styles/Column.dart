import 'package:flutter/material.dart';

class FColumn extends StatelessWidget {
  final Widget child;
  final FColumnType columnType;
  final double gridSpace;

  const FColumn({this.child, this.columnType, this.gridSpace = 6});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(left: gridSpace, right: gridSpace),
        width: columnType.toWidthValue *
            (MediaQuery.of(context).size.width - 2 * gridSpace),
        child: child,
      );
}

enum FColumnType { col_25, col_33, col_50, col_66, col_75, col_100 }

extension FColumnTypeExtension on FColumnType {
  static const widthValues = {
    FColumnType.col_25: 0.25,
    FColumnType.col_33: 1 / 3,
    FColumnType.col_50: 0.50,
    FColumnType.col_66: 2 / 3,
    FColumnType.col_75: 0.75,
    FColumnType.col_100: 1.0,
  };

  double get toWidthValue => widthValues[this];
}
