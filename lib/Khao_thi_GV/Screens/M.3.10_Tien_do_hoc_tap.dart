import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/Table2Progressreport.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/TableProgressreport.dart';
// import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.3.11_Hieu_suat_hoc_tap.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import 'package:khao_thi_gv/F.Utils/Convert.dart';

class Progressreport extends StatefulWidget {
  int studentId;
  String studentName;
  String className;
  Progressreport(this.studentId, {this.studentName, this.className});
  @override
  _ProgressreportState createState() => _ProgressreportState();
}

class _ProgressreportState extends State<Progressreport> {
  int selectedRadio;
  int selectedRadioTitle;
  String resultString;
  String searchValue;
  final StudentReportDA studentReportDA = StudentReportDA();
  List<TestOutline> dataTestOutline = [];
  List<TestOutline> searchTestOutline = [];

  List<StudentReport> studentReports = [];
  List<TestBlueprintsItem> testBlueprint = [];
  bool isLoading = true;
  int idkhungde = 0;
  String fromdate;
  String todate;
  String sevendayNear;
  String monthNear;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTitle = 0;
    getData();
    search();
  }

  Future<void> search() async {
    setState(() {
      isLoading = true;
    });
    try {
      await getDataTable2();
      await getStatsTestBlueprint();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getDataTable2() async {
    final daStudent = StudentReportDA();
    final data = await daStudent.getTableStudentReport(
        widget.studentId, idkhungde, fromdate, todate);
    if (data.code == 200) {
      setState(() {
        studentReports = data.studentReportItem.studentReport;
      });
    }
  }

  Future<void> getStatsTestBlueprint() async {
    final daStudent = StudentReportDA();
    final data = await daStudent.getStatsTestBlueprint(
        widget.studentId, idkhungde, fromdate, todate);
    if (data.code == 200) {
      setState(() {
        testBlueprint = data.testBlueprintsItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: FAppBar(
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            backgroundColor: FColors.transparent,
            color: FColors.grey9,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          headerCenter: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FText(
                  '${widget.studentName}',
                  style: FTextStyle.titleModules3,
                ),
                FText(
                  '${widget.className}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          headerActions: [
            Container(
              width: 48,
            )
          ],
          backgroundColor: FColors.grey1,
          bottom: TabBar(
            indicatorColor: FColors.blue6,
            labelColor: FColors.blue6,
            unselectedLabelColor: FColors.grey7,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  'Tiến độ học tập',
                ),
              ),
              Tab(
                child: Text(
                  'Hiệu suất học tập',
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      FButton(
                        title: 'Chọn khung đề thi',
                        backgroundColor: FColors.grey3,
                        color: FColors.grey8,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        leftIcon: FOutlinedIcons.check,
                        size: FButtonSize.size24,
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: FColors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(top: 24.0),
                                child: SingleChildScrollView(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                            StateSetter mystate) =>
                                        FBottomSheet(
                                      mainAxisSize: MainAxisSize.max,
                                      header: FModal(
                                        title: FText('Tiến độ học tập',
                                            style: FTextStyle.titleModules3),
                                      ),
                                      body: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        padding: EdgeInsets.all(16),
                                        color: FColors.grey1,
                                        child: Column(
                                          children: [
                                            FTextField(
                                              label: 'Chọn khung đề thi',
                                              value: searchValue,
                                              size: FTextFieldSize.size40,
                                              onChanged: (value) {
                                                mystate(
                                                  () {
                                                    searchTestOutline =
                                                        dataTestOutline
                                                            .where((element) =>
                                                                element.name
                                                                    .contains(
                                                                        value))
                                                            .toList();
                                                  },
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    searchTestOutline.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () {
                                                      idkhungde =
                                                          searchTestOutline[
                                                                  index]
                                                              .id;
                                                      search();
                                                      Navigator.pop(context);
                                                    },
                                                    title: FText(
                                                        '${searchTestOutline[index].name}'),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: FButton(
                          title: 'Lọc theo thời gian',
                          backgroundColor: FColors.grey3,
                          color: FColors.grey8,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          leftIcon: FOutlinedIcons.filter,
                          size: FButtonSize.size24,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: FColors.transparent,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter mystate) =>
                                      FBottomSheet(
                                    header: FModal(
                                      title: FText('Lọc theo thời gian',
                                          style: FTextStyle.titleModules3),
                                    ),
                                    body: Container(
                                      color: FColors.grey1,
                                      child: Column(
                                        children: [
                                          FRadioButton(
                                            value: 1,
                                            groupValue: selectedRadio,
                                            label: 'Hôm nay',
                                            onChanged: (val) {
                                              mystate(() {
                                                selectedRadio = val;
                                                var now = new DateTime.now();
                                                fromdate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                                todate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day + 1)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                              });
                                              search();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FRadioButton(
                                            value: 2,
                                            groupValue: selectedRadio,
                                            label: '7 ngày gần đây',
                                            onChanged: (val) {
                                              mystate(() {
                                                selectedRadio = val;
                                                var now = new DateTime.now();

                                                fromdate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day - 7)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                                todate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day + 1)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                              });
                                              search();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FRadioButton(
                                            value: 3,
                                            groupValue: selectedRadio,
                                            label: '30 ngày gần đây',
                                            onChanged: (val) {
                                              mystate(() {
                                                selectedRadio = val;
                                                var now = new DateTime.now();

                                                fromdate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day - 30)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                                todate = new DateTime.utc(
                                                        now.year,
                                                        now.month,
                                                        now.day + 1)
                                                    .format(
                                                        'yyyy-MM-dd HH:mm:ss');
                                              });
                                              search();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FRadioButton(
                                            value: 4,
                                            groupValue: selectedRadio,
                                            label: 'Tùy chọn',
                                            onChanged: (val) {
                                              mystate(() async {
                                                selectedRadio = val;
                                                final List<DateTime> picked =
                                                    await DateRagePicker
                                                        .showDatePicker(
                                                  context: context,
                                                  initialFirstDate:
                                                      new DateTime.now(),
                                                  initialLastDate:
                                                      (new DateTime.now()).add(
                                                          new Duration(
                                                              days: 7)),
                                                  firstDate: new DateTime(2018),
                                                  lastDate: new DateTime(2022),
                                                );
                                                if (picked != null &&
                                                    picked.length == 2) {
                                                  // ignore: avoid_print
                                                  print(picked);
                                                  fromdate = picked[1].format(
                                                      'yyyy-MM-dd HH:mm:ss');
                                                  todate = picked[0].format(
                                                      'yyyy-MM-dd HH:mm:ss');
                                                  search();
                                                }

                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? StaticNumber.baseShimmer
                      : Scrollbar(
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: TableProgressreport(testBlueprint),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 24),
                                    child: Table2Progressreport(studentReports),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
            Performancereport(
              dataTestOutline: dataTestOutline,
              studentId: widget.studentId,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    final da = TestOutLineDA();

    final result = await da.getInfo();
    if (result.code != 200) {
      return;
    }
    setState(() {
      dataTestOutline = result.testOutlineItem.testOutlines;
      searchTestOutline = dataTestOutline;
    });

    // ignore: avoid_print
    print(result.code);
  }
}
