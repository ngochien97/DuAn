import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.3.7_Chi_tiet_thi_sinh.dart';
import 'package:provider/provider.dart';

import '../../../../../F.Utils/Convert.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Components/SnackBar.dart';
import '../../../../Components/Text.dart';
import '../../../../Skins/Icon.dart';
import '../../../../Skins/KhaoThi/SkinColor.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/Colors.dart';
import '../../../../Styles/Icons.dart';
import '../../../../Styles/Spacer.dart';
import '../../Provider/TestTakerProvider.dart';
import '../../TakerGroupStatus.dart';

class TakerView extends StatefulWidget {
  final int id;
  const TakerView(this.id);
  @override
  _TakerViewState createState() => _TakerViewState();
}

class _TakerViewState extends State<TakerView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchEditingController =
      TextEditingController();

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >=
          notification.metrics.maxScrollExtent - 150) {
        final provider = Provider.of<TestTakerProvider>(context, listen: false);
        provider.loadMoreData(widget.id);
      }
    }
    return true; //
  }

  @override
  void initState() {
    final testTakerProvider =
        Provider.of<TestTakerProvider>(context, listen: false);
    testTakerProvider.loadData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: FColors.grey1,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FTextField(
              size: FTextFieldSize.size40,
              label: 'Nhập tên thí sinh, mã thí sinh',
              leftIcon: FOutlinedIcons.search,
              controller: _searchEditingController,
              // ignore: avoid_bool_literals_in_conditional_expressions
              clearable: _searchEditingController.text != '' ? true : false,
              onChanged: (value) {
                final testTakerProvider =
                    Provider.of<TestTakerProvider>(context, listen: false);
                testTakerProvider.setFilter(value);
                testTakerProvider.loadData(widget.id);
              },
            ),
            FSpacer.space16px,
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FButton(
                    size: FButtonSize.size24,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    title: 'Theo lớp',
                    rightIcon: FFilledIcons.caret_down,
                    backgroundColor: FColors.transparent,
                    color: FColors.grey7,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: FColors.transparent,
                        builder: (context) => BottomSheetSwitch(widget.id),
                      );
                    },
                  ),
                  FDivider(
                    vertical: true,
                  ),
                  FButton(
                    size: FButtonSize.size24,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    title: 'Theo mã đề',
                    rightIcon: FFilledIcons.caret_down,
                    backgroundColor: FColors.transparent,
                    color: FColors.grey7,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: FColors.transparent,
                          builder: (context) =>
                              BottomSheetWitchFromCode(widget.id));
                    },
                  ),
                  FDivider(
                    vertical: true,
                  ),
                  FButton(
                    size: FButtonSize.size24,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    title: 'trạng thái',
                    rightIcon: FFilledIcons.caret_down,
                    backgroundColor: FColors.transparent,
                    color: FColors.grey7,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: FColors.transparent,
                        builder: (context) => BottomSheetWitchStatus(widget.id),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                child: NotificationListener(
                  onNotification: _onNotification,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final provider = Provider.of<TestTakerProvider>(context,
                          listen: false);
                      await provider.loadData(widget.id);
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            width: 1000,
                            child: Table(
                                border: TableBorder.symmetric(
                                  inside: BorderSide(
                                      width: 0.5, color: FColors.grey3),
                                ),
                                columnWidths: const {
                                  0: FixedColumnWidth(70.0),
                                  1: FixedColumnWidth(139.0),
                                  2: FixedColumnWidth(130.0),
                                  3: FixedColumnWidth(101.0),
                                  4: FixedColumnWidth(89.0),
                                  5: FixedColumnWidth(151.0),
                                  6: FixedColumnWidth(151.0),
                                  7: FixedColumnWidth(100.0),
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
                                            child: FText(
                                              'STT',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Họ và tên',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Mã dự thi',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Điểm',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Mã đề',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Giờ rút đề',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Giờ nộp',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: FText(
                                            'Lớp',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ]),
                                  ...buildRow(),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  List<TableRow> buildRow() {
    final takerGroupProvider =
        Provider.of<TestTakerProvider>(context, listen: true);
    var i = 1;
    final lst = <TableRow>[];
    if (takerGroupProvider.sutdents == null) {
      return lst;
    }

    for (final student in takerGroupProvider.sutdents) {
      var score = student.score;

      var scoreColor = FColors.grey9;

      switch (student.status) {
        case TestTakerStatusBase.chuaThi:
        case TestTakerStatusBase.dangThi:
        case TestTakerStatusBase.choChamDiem:
          score = testTakerStatus[student.status];
          scoreColor = testTakerGroupStatus[student.status];
          break;
        case TestTakerStatusBase.daThi:
          score = student.score;
          scoreColor = FColors.grey9;
          break;
        default:
      }

      lst.add(
        TableRow(children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              padding: EdgeInsets.all(10),
              child: FText(
                '${i++}',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6,
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: FColors.transparent,
                    builder: (context) =>
                        StudentDetailScreen(student.id, student.name));
              },
              child: Container(
                padding: EdgeInsets.only(left: 12),
                child: FText(
                  '${student.name}',
                  textAlign: TextAlign.center,
                  style: FTextStyle.titleModules6,
                ),
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              onLongPress: () {
                FlutterClipboard.copy('${student.code}')
                    .then((value) => showFSnackBar(
                        context,
                        FSnackBar(
                          message: FText(
                            'Đã sao chép',
                            color: FColors.grey1,
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: FColors.grey9,
                          borderRadius: 8.0,
                          icon: FIcon(
                            icon: FOutlinedIcons.check_circle,
                            color: const <Color>[FColors.grey1],
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 8.0),
                        )));
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FIcon(
                        icon: FFilledIcons.copy_2, color: [SkinColor.primary]),
                    FText(
                      '${student.code}',
                      textAlign: TextAlign.center,
                      style: FTextStyle.titleModules6,
                    )
                  ],
                ),
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
              '${score ?? ""}',
              color: scoreColor,
              textAlign: TextAlign.center,
              style: FTextStyle.titleModules6,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
              '${student.testFormCode ?? ""}',
              textAlign: TextAlign.center,
              style: FTextStyle.titleModules6,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
              '${student.startedAt.format("dd/MM/yyyy HH:mm")}',
              textAlign: TextAlign.center,
              style: FTextStyle.titleModules6,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FText(
              '${student.submittedAt.format("dd/MM/yyyy HH:mm")}',
              textAlign: TextAlign.center,
              style: FTextStyle.titleModules6,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: FText(
                '${student.className}',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules6,
              ),
            ),
          ),
        ]),
      );
    }
    return lst;
  }
}

class BottomSheetSwitch extends StatefulWidget {
  final int id;

  const BottomSheetSwitch(this.id);

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  List<Widget> buildFilterClass() {
    final provider = Provider.of<TestTakerProvider>(context, listen: true);
    final lst = <Widget>[];

    if (provider.classStr == null) {
      return lst;
    }

    for (final item in provider.classStr) {
      final color = item.isActive ? SkinColor.primary : FColors.grey6;
      lst.add(
        Container(
          margin: EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
          height: 30,
          child: OutlineButton(
            color: color,
            borderSide: BorderSide(color: color),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              provider.setActiveClass(item);
            },
            child: FText(
              '${item.name}',
              color: color,
            ),
          ),
        ),
      );
    }
    return lst;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FBottomSheet(
        header: FModal(
          iconAction: Container(
            width: 48,
          ),
          title: FText(
            'Lọc theo lớp',
            textAlign: TextAlign.center,
            color: FColors.grey9,
            style: FTextStyle.titleModules3,
          ),
          textAction: FButton(
            size: FButtonSize.size48,
            title: 'Xong',
            backgroundColor: FColors.transparent,
            block: true,
            color: SkinColor.primary,
            onPressed: () {
              final provider =
                  Provider.of<TestTakerProvider>(context, listen: false);
              provider.loadData(widget.id);
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: FColors.grey1,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Wrap(
              children: <Widget>[
                ...buildFilterClass(),
              ],
            ),
          ),
        ),
      );
}

class BottomSheetWitchFromCode extends StatefulWidget {
  final int id;

  const BottomSheetWitchFromCode(this.id);

  @override
  _BottomSheetSwitchFromCode createState() => _BottomSheetSwitchFromCode();
}

class _BottomSheetSwitchFromCode extends State<BottomSheetWitchFromCode> {
  List<Widget> buildFilterForm() {
    final provider = Provider.of<TestTakerProvider>(context, listen: true);
    final lst = <Widget>[];

    if (provider.formCodes == null) {
      return lst;
    }

    for (final item in provider.formCodes) {
      final color = item.item2 ? SkinColor.primary : FColors.grey6;
      lst.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          height: 30,
          child: OutlineButton(
            color: color,
            borderSide: BorderSide(color: color),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              provider.setActiveFormCode(item);
            },
            child: FText(
              '${item.item1}',
              color: color,
            ),
          ),
        ),
      );
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) => FBottomSheet(
        header: FModal(
          iconAction: Container(
            width: 48,
          ),
          title: FText(
            'Lọc theo mã đề',
            color: FColors.grey9,
            style: FTextStyle.titleModules3,
            textAlign: TextAlign.center,
          ),
          textAction: FButton(
            backgroundColor: FColors.transparent,
            color: SkinColor.primary,
            title: 'Xong',
            block: true,
            size: FButtonSize.size48,
            onPressed: () {
              final provider =
                  Provider.of<TestTakerProvider>(context, listen: false);
              provider.loadData(widget.id);
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            color: FColors.grey1,
            child: Wrap(
              spacing: 2,
              runSpacing: 8,
              children: <Widget>[
                ...buildFilterForm(),
              ],
            ),
          ),
        ),
      );
}

class BottomSheetWitchStatus extends StatefulWidget {
  final int id;

  const BottomSheetWitchStatus(this.id);

  @override
  _BottomSheetWitchStatus createState() => _BottomSheetWitchStatus();
}

class _BottomSheetWitchStatus extends State<BottomSheetWitchStatus> {
  String choice;

  void radioButtonChanges(String value) {
    final provider = Provider.of<TestTakerProvider>(context, listen: false);
    provider.setActiveStatus(value == null ? null : int.parse(value));
  }

  List<Widget> buildFilterStatus() {
    final provider = Provider.of<TestTakerProvider>(context, listen: true);
    final lst = <Widget>[];

    if (provider.formCodes == null) {
      return lst;
    }
    lst.add(FRadioButton(
      label: 'Tất cả',
      groupValue: provider.status == null ? null : '${provider.status}',
      onChanged: radioButtonChanges,
      value: null,
    ));
    for (final item in testTakerStatus.keys) {
      lst.add(Row(
        children: <Widget>[
          Expanded(
            child: FRadioButton(
              label: testTakerStatus[item],
              groupValue: '${provider.status}',
              value: '$item',
              onChanged: radioButtonChanges,
            ),
          )
        ],
      ));
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) => FBottomSheet(
        header: FModal(
          iconAction: Container(
            width: 48,
          ),
          title: FText(
            'Lọc theo trạng thái',
            color: FColors.grey9,
            style: FTextStyle.titleModules3,
            textAlign: TextAlign.center,
          ),
          textAction: FButton(
            size: FButtonSize.size48,
            backgroundColor: FColors.transparent,
            color: SkinColor.primary,
            block: true,
            title: 'Xong',
            onPressed: () {
              final provider =
                  Provider.of<TestTakerProvider>(context, listen: false);
              provider.loadData(widget.id);
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: FColors.grey1,
          ),
          child: Column(
            children: <Widget>[
              ...buildFilterStatus(),
            ],
          ),
        ),
      );
}
