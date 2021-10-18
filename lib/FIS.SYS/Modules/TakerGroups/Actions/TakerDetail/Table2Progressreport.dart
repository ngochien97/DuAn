import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/F.Utils/Convert.dart';

final ScrollController _scrollController = ScrollController();

class Table2Progressreport extends StatefulWidget {
  List<StudentReport> dataTable2Progressreport = [];
  Table2Progressreport(this.dataTable2Progressreport);
  @override
  _Table2ProgressreportState createState() => _Table2ProgressreportState();
}

class _Table2ProgressreportState extends State<Table2Progressreport> {
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FColors.grey1,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: FText(
              'Bài thi',
              style: FTextStyle.titleModules5,
            ),
          ),
          SizedBox(height: 12),
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
                    width: 1672,
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(width: 0.5, color: FColors.grey3),
                      ),
                      columnWidths: const {
                        1: FixedColumnWidth(350.0),
                        2: FixedColumnWidth(308.0),
                        3: FixedColumnWidth(68.0),
                        4: FixedColumnWidth(58.0),
                        5: FixedColumnWidth(102.0),
                        6: FixedColumnWidth(220.0),
                        7: FixedColumnWidth(220.0),
                        8: FixedColumnWidth(143.0),
                        9: FixedColumnWidth(144.0),
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
                              child: FText('Kíp thi',
                                  textAlign: TextAlign.left,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Đề thi',
                                  textAlign: TextAlign.left,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Loại',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Điểm',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Số câu đúng',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Giờ rút đề',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Giờ nộp',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Thời gian làm bài',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: FText('Điểm trung bình đề',
                                  textAlign: TextAlign.center,
                                  style: FTextStyle.titleModules5),
                            ),
                          ],
                        ),
                        ...buildRow(widget.dataTable2Progressreport, context)
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

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  List<TableRow> buildRow(
      List<StudentReport> dataTable2Progressreport, BuildContext context) {
    var i = 1;

    final lst = <TableRow>[];
    if (dataTable2Progressreport == null) {
      return lst;
    }
    for (final item in dataTable2Progressreport) {
      final datediff = item.submittedAt.difference(item.startedAt);
      final day = datediff.inDays;
      var dt = _printDuration(datediff);
      if (day > 0) {
        dt = '${'$day ngày '}$dt';
      }
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
            child: FText('${item.testTakerGroupName}',
                textAlign: TextAlign.left, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.testFormName}',
                textAlign: TextAlign.left, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
                '${item.presentation == false ? "đề thi" : "kíp thi "}',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.score}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.correctAnswerCount} / ${item.totalItems}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.startedAt.format('dd/MM HH:mm')}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.submittedAt.format('dd/MM HH:mm')}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${dt}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText('${item.testTakerMarkAvgDone ?? "-"}',
                textAlign: TextAlign.center, style: FTextStyle.titleModules6),
          ),
        ]),
      );
    }
    return lst;
  }

  // Future<void> getData(int id, int testOutlineId) async {
  //   final daStudent = StudentReportDA();
  //   final resultStudent = await daStudent.getInfo(id, testOutlineId);
  //   setState(() {
  //     // dataTable2Progressreport = resultStudent.studentReportItem.studentReport;
  //   });
  //   // ignore: avoid_print
  //   print(resultStudent.code);
  // }
}
