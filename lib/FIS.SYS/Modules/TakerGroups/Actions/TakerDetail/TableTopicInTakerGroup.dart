import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/Colors.dart';

import '../../TakerClass.dart';

final ScrollController _scrollController2 = ScrollController();
Widget tableInTopic(List<TakerClass> datas) => Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: FColors.grey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: FText(
              'Thống kê theo đề',
              style: FTextStyle.titleModules5,
            ),
          ),
          SizedBox(height: 5),
          Scrollbar(
            controller: _scrollController2,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController2,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FColors.grey3,
                      ),
                    ),
                    width: 800,
                    child: Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(width: 0.5, color: FColors.grey3),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(90.0),
                          1: FixedColumnWidth(115.0),
                          2: FixedColumnWidth(102.0),
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
                                    child: FText('Mã đề',
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
                                  child: FText('Số câu đúng TB',
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
                          ...buildRow(datas),
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

List<TableRow> buildRow(List<TakerClass> datas) {
  final lst = <TableRow>[];
  if (datas == null) {
    return lst;
  }
  for (final item in datas) {
    lst.add(
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.all(10),
            child: FText(
              '${item.testFormCode}',
              textAlign: TextAlign.center,
              style: FTextStyle.titleModules6,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              item.testTakerStatusTotal != null
                  ? FTag(
                      title: '${item.testTakerStatusDone}',
                      backgroundColor: FColors.geek_blue1,
                      color: FColors.geek_blue6,
                    )
                  : Container(),
              // item.testTakerStatusDone != null
              //     ? FTag(
              //         title: '${item.testTakerStatusDone}',
              //         size: FTagSize.small,
              //         backgroundColor: FColors.cyan1,
              //         color: FColors.green6,
              //       )
              //     : Container(),
              // item.testTakerStatusTodo != null
              //     ? FTag(
              //         title: '${item.testTakerStatusTodo}',
              //         size: FTagSize.small,
              //         backgroundColor: FColors.gold1,
              //         color: FColors.orange6,
              //       )
              //     : Container(),
            ],
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerQuestionCorrectAvg ?? "-"}',
              textAlign: TextAlign.center, style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkAvg ?? "-"}',
              textAlign: TextAlign.center, style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkDeviation ?? "-"}',
              textAlign: TextAlign.center, style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkMin ?? "-"}',
              textAlign: TextAlign.center, style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.testTakerMarkMax ?? "-"}',
              textAlign: TextAlign.center, style: FTextStyle.titleModules6),
        ),
      ]),
    );
  }
  return lst;
}
