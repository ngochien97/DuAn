import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.3.10_Tien_do_hoc_tap.dart';

import '../../../../Components/Text.dart';
import '../../../../Skins/KhaoThi/SkinColor.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/StyleBase.dart';
import '../../TestTaker.dart';

final ScrollController scrollController1 = ScrollController();
Widget studentInClass(List<TestTaker> testTakers, BuildContext context) =>
    Container(
      color: FColors.grey1,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FText(
            'Thống kê theo học sinh',
            style: FTextStyle.titleModules5,
          ),
          FSpacer.space8px,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: FColors.grey3,
              ),
            ),
            child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(width: 0.5, color: FColors.grey3),
                ),
                columnWidths: const {
                  0: FixedColumnWidth(50),
                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        color: FColors.grey2,
                      ),
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child:
                                FText('STT', style: FTextStyle.titleModules5),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: FText('Họ và tên',
                                textAlign: TextAlign.center,
                                style: FTextStyle.titleModules5),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: FText('Điểm',
                                textAlign: TextAlign.center,
                                style: FTextStyle.titleModules5),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: FText('Số câu đúng',
                                textAlign: TextAlign.center,
                                style: FTextStyle.titleModules5),
                          ),
                        ),
                      ]),
                  ...buildRow(testTakers, context),
                ]),
          )
        ],
      ),
    );

List<TableRow> buildRow(List<TestTaker> datas, BuildContext context) {
  final lst = <TableRow>[];
  var i = 1;
  if (datas == null) {
    return lst;
  }
  for (final item in datas) {
    lst.add(
      TableRow(children: [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                child: FText('${i++}', style: FTextStyle.titleModules6),
              ),
            )),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Progressreport(
                          item.studentId,
                          studentName: item.name,
                          className: item.className,
                        )),
              );
            },
            child: FText('${item.name}',
                textAlign: TextAlign.center,
                color: SkinColor.primary,
                style: FTextStyle.titleModules6),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.score ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: FText('${item.point ?? "-"}/${item.totalPoint ?? "-"}',
              textAlign: TextAlign.center,
              color: FColors.grey8,
              style: FTextStyle.titleModules6),
        ),
      ]),
    );
  }
  return lst;
}
