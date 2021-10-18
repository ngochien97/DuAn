import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/StatsTestOutline/StatsTestOutlineItem.dart';
// import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Provider/DetailLearning.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/F.Utils/Convert.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Effect.dart';

final ScrollController _scrollController = ScrollController();

class TablePerformancereport extends StatefulWidget {
  List<StatsTestOutlineItem> testBlueprintsItems = [];
  TablePerformancereport(this.testBlueprintsItems);
  @override
  _TablePerformancereportState createState() => _TablePerformancereportState();
}

class _TablePerformancereportState extends State<TablePerformancereport> {
  List<StudentReport> dataTablePerformancereport = [];
  @override
  Widget build(BuildContext context) {
    if (widget.testBlueprintsItems.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [FEffect.elevation1],
              color: FColors.grey1,
            ),
            padding: const EdgeInsets.all(8),
            child: const FText(
              'Chưa có dữ liệu',
              style: FTextStyle.titleModules4,
            ),
          ),
        ),
      );
    }
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
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FColors.grey3,
                      ),
                    ),
                    width: 970,
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(width: 0.5, color: FColors.grey3),
                      ),
                      columnWidths: const {
                        1: FixedColumnWidth(226.0),
                        2: FixedColumnWidth(112.0),
                        3: FixedColumnWidth(100.0),
                        4: FixedColumnWidth(100.0),
                        5: FixedColumnWidth(100.0),
                        6: FixedColumnWidth(120.0),
                        7: FixedColumnWidth(154.0),
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
                                padding: EdgeInsets.all(12),
                                child: FText('STT',
                                    textAlign: TextAlign.center,
                                    style: FTextStyle.titleModules5),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Đơn vị kiến thức',
                                  textAlign: TextAlign.left,
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
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Cập nhật gần nhất',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                          ],
                        ),
                        ...buildRow(widget.testBlueprintsItems, context),
                      ],
                    ),
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
      List<StatsTestOutlineItem> testBlueprintsItems, BuildContext context) {
    var i = 1;
    final lst = <TableRow>[];
    if (testBlueprintsItems == null) {
      return lst;
    }
    for (final item in testBlueprintsItems) {
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
            child: FText('${item.name}',
                textAlign: TextAlign.start, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.txtLevelGraded ?? "-"}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
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
                item.stats5 != null && item.stats1.itemCount > 0
                    ? '${item.stats5?.correctAnswerCount ?? '-'}/${item.stats5?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                item.stats7 != null && item.stats1.itemCount > 0
                    ? '${item.stats7?.correctAnswerCount ?? '-'}/${item.stats7?.itemCount ?? ''}'
                    : '-',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                '${item.lastActivity == null ? '-' : item.lastActivity.format('dd/MM HH:mm')}',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
        ]),
      );
    }
    return lst;
  }
}
