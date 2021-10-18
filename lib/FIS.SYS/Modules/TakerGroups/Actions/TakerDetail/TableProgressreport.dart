import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsItem.dart';

import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/F.Utils/Convert.dart';

final ScrollController _scrollController = ScrollController();

class TableProgressreport extends StatefulWidget {
  List<TestBlueprintsItem> dataTableProgressreport = [];
  TableProgressreport(this.dataTableProgressreport);
  @override
  _TableProgressreportState createState() => _TableProgressreportState();
}

class _TableProgressreportState extends State<TableProgressreport> {
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    var correctAnswerCount1 = 0;
    var correctAnswerCount3 = 0;
    var correctAnswerCount5 = 0;
    var correctAnswerCount7 = 0;
    var itemCount1 = 0;
    var itemCount3 = 0;
    var itemCount5 = 0;
    var itemCount7 = 0;

    widget.dataTableProgressreport.forEach((element) {
      correctAnswerCount1 += element.stats1.correctAnswerCount;
      correctAnswerCount3 += element.stats3.correctAnswerCount;
      correctAnswerCount5 += element.stats5.correctAnswerCount;
      correctAnswerCount7 += element.stats7.correctAnswerCount;
      itemCount1 += element.stats1.itemCount;
      itemCount3 += element.stats3.itemCount;
      itemCount5 += element.stats5.itemCount;
      itemCount7 += element.stats7.itemCount;
    });
    return Container(
      color: FColors.grey1,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: FColors.grey3,
                          ),
                        ),
                        width: 1133,
                        child: Table(
                          border: TableBorder.symmetric(
                            inside:
                                BorderSide(width: 0.5, color: FColors.grey3),
                          ),
                          columnWidths: const {
                            1: FixedColumnWidth(230.0),
                            2: FixedColumnWidth(174.0),
                            3: FixedColumnWidth(151.0),
                            4: FixedColumnWidth(99.0),
                            5: FixedColumnWidth(100.0),
                            6: FixedColumnWidth(100.0),
                            7: FixedColumnWidth(100.0),
                            8: FixedColumnWidth(123.0),
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
                                    child: FText('STT',
                                        textAlign: TextAlign.center,
                                        style: FTextStyle.titleModules5),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Đơn vị kiến thức',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Ngày',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Mức nhận thức',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: FText('Thay đổi',
                                      textAlign: TextAlign.center,
                                      style: FTextStyle.titleModules5),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Column(
                                    children: [
                                      FText('Biết',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.titleModules5),
                                      FText('Số câu đúng',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.tabbar),
                                    ],
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Column(
                                    children: [
                                      FText('Hiểu',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.titleModules5),
                                      FText('Số câu đúng',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.tabbar),
                                    ],
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Column(
                                    children: [
                                      FText('Vận dụng',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.titleModules5),
                                      FText('Số câu đúng',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.tabbar),
                                    ],
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Column(
                                    children: [
                                      FText('Vận dụng cao',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.titleModules5),
                                      FText('Số câu đúng',
                                          textAlign: TextAlign.center,
                                          style: FTextStyle.tabbar),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ...buildRow(widget.dataTableProgressreport, context)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 1133,
                        child: Table(
                          border: TableBorder.symmetric(
                            inside:
                                BorderSide(width: 0.5, color: FColors.grey3),
                          ),
                          columnWidths: const {
                            1: FixedColumnWidth(100.0),
                            2: FixedColumnWidth(100.0),
                            3: FixedColumnWidth(100.0),
                            4: FixedColumnWidth(123.0),
                          },
                          children: [
                            TableRow(children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: FText(
                                      'Tổng số (${widget.dataTableProgressreport.length} bản ghi)',
                                      textAlign: TextAlign.left,
                                      style: FTextStyle.titleModules6),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: FText(
                                    itemCount1 > 0
                                        ? '$correctAnswerCount1/$itemCount1'
                                        : '-',
                                    textAlign: TextAlign.center,
                                    style: FTextStyle.titleModules6),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: FText(
                                    itemCount3 > 0
                                        ? '$correctAnswerCount3/$itemCount3'
                                        : '-',
                                    textAlign: TextAlign.center,
                                    style: FTextStyle.titleModules6),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: FText(
                                    itemCount5 > 0
                                        ? '$correctAnswerCount5/$itemCount5'
                                        : '-',
                                    textAlign: TextAlign.center,
                                    style: FTextStyle.titleModules6),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: FText(
                                    itemCount7 > 0
                                        ? '$correctAnswerCount7/$itemCount7'
                                        : '-',
                                    textAlign: TextAlign.center,
                                    style: FTextStyle.titleModules6),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<TableRow> buildRow(
      List<TestBlueprintsItem> dataTableProgressreport, BuildContext context) {
    var i = 1;
    final lst = <TableRow>[];
    if (dataTableProgressreport == null) {
      return lst;
    }
    for (final item in dataTableProgressreport) {
      lst.add(
        TableRow(children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              padding: EdgeInsets.all(12),
              child: FText(
                '${i++}',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6,
              ),
            ),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (item.testBlueprintCode != null &&
                        item.testBlueprintCode != '')
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Chip(
                          label: FText('${item.testBlueprintCode}',
                              textAlign: TextAlign.center,
                              style: FTextStyle.titleModules6),
                          backgroundColor: FColors.yellow6,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: FText('${item.testBlueprintName}',
                          textAlign: TextAlign.start,
                          // overflow: TextOverflow.visible,
                          maxLines: 2,
                          style: FTextStyle.titleModules6),
                    ),
                  ])),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.createdAt.format('dd/MM HH:mm')}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.txtLevelGraded}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: item.getChangeWidget,
              )),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                item.stats1 != null && item.stats1.itemCount > 0
                    ? '${item.stats1?.correctAnswerCount ?? '-'}/${item.stats1?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                item.stats3 != null && item.stats3.itemCount > 0
                    ? '${item.stats3?.correctAnswerCount ?? '-'}/${item.stats3?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                item.stats5 != null && item.stats5.itemCount > 0
                    ? '${item.stats5?.correctAnswerCount ?? '-'}/${item.stats5?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                item.stats7 != null && item.stats7.itemCount > 0
                    ? '${item.stats7?.correctAnswerCount ?? '-'}/${item.stats7?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
        ]),
      );
    }
    return lst;
  }
}
