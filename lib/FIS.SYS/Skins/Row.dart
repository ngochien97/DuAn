import 'package:Framework/FIS.SYS/Styles/Column.dart';
import 'package:flutter/material.dart';

class FRow extends StatelessWidget {
  // các phần tử con
  final List<FColumn> children;
  // giá trị khoảng cách giữa các phân tử con
  final FGridSpace gridSpace;

  FRow({this.children, this.gridSpace = FGridSpace.large});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: gridSpace.value, right: gridSpace.value),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          for (var element in children)
            FColumn(
              child: element.child,
              columnType: element.columnType,
              gridSpace: gridSpace.value,
            )
        ],
      ),
    );
  }
}

enum FGridSpace {
  xSmall,
  small,
  medium,
  large,
  xLarge,
}

extension FGridSpaceExtension on FGridSpace {
  static const spaceValues = {
    FGridSpace.xSmall: 2.0,
    FGridSpace.small: 4.0,
    FGridSpace.medium: 6.0,
    FGridSpace.large: 8.0,
    FGridSpace.xLarge: 10.0,
  };

  double get value => spaceValues[this];
}
