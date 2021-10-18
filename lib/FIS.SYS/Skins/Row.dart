import 'package:flutter/material.dart';
import '../Styles/Column.dart';

class FRow extends StatelessWidget {
  // các phần tử con
  final List<FColumn> children;
  // giá trị khoảng cách giữa các phân tử con
  final FGridSpace gridSpace;

  const FRow({this.children, this.gridSpace = FGridSpace.large});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(left: gridSpace.value, right: gridSpace.value),
        child: Wrap(
          children: [
            for (var element in children)
              FColumn(
                columnType: element.columnType,
                gridSpace: gridSpace.value,
                child: element.child,
              )
          ],
        ),
      );
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
