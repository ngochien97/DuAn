import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../Khao_thi_GV/Screens/M.3.6_Chi_tiet_lop.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/Colors.dart';
import '../../TakerClass.dart';

final ScrollController _scrollController1 = ScrollController();
Widget tableInClass(
        List<TakerClass> datas, String className, BuildContext context) =>
    Container(
      color: FColors.grey1,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: FText(
              'Thống kê theo lớp',
              style: FTextStyle.titleModules5,
            ),
          ),
          SizedBox(height: 5),
          Scrollbar(
            controller: _scrollController1,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController1,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FColors.grey3,
                      ),
                    ),
                    width: 700,
                    child: Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(width: 0.5, color: FColors.grey3),
                        ),
                        columnWidths: const {
                          1: FixedColumnWidth(129.0),
                          2: FixedColumnWidth(92.0),
                          3: FixedColumnWidth(111.0),
                          4: FixedColumnWidth(130.0),
                          5: FixedColumnWidth(131.0),
                        },
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                color: FColors.grey2,
                              ),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: FText('Lớp',
                                        textAlign: TextAlign.center,
                                        style: FTextStyle.titleModules5),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Số thí sinh',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Điểm TB',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Độ lệch chuẩn',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Điểm thấp nhất',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Điểm cao nhất',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                              ]),
                          ...buildRow(datas, context)
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

List<TableRow> buildRow(List<TakerClass> datas, BuildContext context) {
  final lst = <TableRow>[];
  if (datas == null) {
    return lst;
  }
  for (final item in datas) {
    lst.add(
      TableRow(children: [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  backgroundColor: FColors.transparent,
                  isScrollControlled: true,
                  builder: (context) => Container(
                    margin: EdgeInsets.only(top: 32),
                    child: ClassDetailScreen(item: item),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: FText('${item.testTakerClassName ?? ''}',
                    textAlign: TextAlign.center,
                    color: FColors.blue6,
                    style: FTextStyle.titleModules6),
              ),
            )),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FTag(
                title: '${item.testTakerStatusTotal}',
                backgroundColor: FColors.geek_blue1,
                color: FColors.geek_blue6,
              ),
              FTag(
                title: '${item.testTakerStatusDone}',
                backgroundColor: FColors.cyan1,
                color: FColors.green6,
              ),
              FTag(
                title: '${item.testTakerStatusTodo}',
                backgroundColor: FColors.gold1,
                color: FColors.orange6,
              ),
            ],
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkAvg ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkDeviation ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkMin ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkMax ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
      ]),
    );
  }
  return lst;
}
