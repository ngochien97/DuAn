import 'package:Framework/FIS.SYS/Components/TableCell.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FTable extends StatelessWidget {
  final Map<int, TableColumnWidth> columnWidths;
  final TableColumnWidth defaultColumnWidth;
  final List<List<FTableCell>> children;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final List<Widget> headers;
  final bool overflow;

  FTable({
    Key key,
    this.children,
    this.columnWidths,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.top,
    this.defaultColumnWidth = const FlexColumnWidth(1.0),
    this.headers,
    this.overflow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        scrollDirection: overflow == true ? Axis.horizontal : Axis.vertical,
        child: Table(
          columnWidths: columnWidths,
          defaultVerticalAlignment: defaultVerticalAlignment,
          defaultColumnWidth: defaultColumnWidth,
          border: TableBorder.all(width: 1, color: FColors.grey3),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: FColors.grey2,
              ),
              children: [
                for (var element in headers)
                  DefaultTextStyle(
                      style: FTextStyle.titleModules5.textStyle, child: element)
              ],
            ),
            for (var i = 0; i < children.length; i++)
              TableRow(
                decoration: BoxDecoration(
                  color: FColors.grey1,
                ),
                children: [
                  for (var element in children[i])
                    DefaultTextStyle(
                        style: FTextStyle.titleModules6.textStyle,
                        child: element)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
