import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/TablePerformancereport.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/StatsTestOutline/StatsTestOutlineItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/F.Utils/Convert.dart';

class Performancereport extends StatefulWidget {
  final List<TestOutline> dataTestOutline;
  int studentId;
  Performancereport({this.dataTestOutline, this.studentId});
  @override
  _PerformancereportState createState() => _PerformancereportState();
}

class _PerformancereportState extends State<Performancereport> {
  int selectedRadio;
  int selectedRadioTitle;
  String searchTestOutlineValue;
  int rowNumber = 0;
  int filterByLevel = 0;
  List<TestOutline> searchTestOutline = [];
  StudentReportDA studentReportDA = StudentReportDA();
  List<StatsTestOutlineItem> testBlueprintsItems = [];
  int testOutlineId = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTitle = 0;
    searchTestOutline = widget.dataTestOutline;
    if (widget.dataTestOutline.isNotEmpty) {
      testOutlineId = widget.dataTestOutline[0].id;
      searchStatsTestOutline();
    }
  }

  Future<void> searchStatsTestOutline() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await studentReportDA.getStatsTestOutline(
          widget.studentId, testOutlineId, rowNumber, filterByLevel);
      if (data.code == 200) {
        testBlueprintsItems = data.testBlueprintsItems;
        // ignore: avoid_print
        print(testBlueprintsItems.length);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Expanded(
                  child: FButton(
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
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(16),
                                    color: FColors.grey1,
                                    child: Column(
                                      children: [
                                        FTextField(
                                          label: 'Chọn khung đề thi',
                                          value: searchTestOutlineValue,
                                          size: FTextFieldSize.size40,
                                          onChanged: (value) {
                                            mystate(
                                              () {
                                                searchTestOutline = widget
                                                    .dataTestOutline
                                                    .where((element) => element
                                                        .name
                                                        .newUnicodeToAscii()
                                                        .contains(value))
                                                    .toList();
                                              },
                                            );
                                          },
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: searchTestOutline.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  testOutlineId =
                                                      searchTestOutline[index]
                                                          .id;
                                                  searchStatsTestOutline();
                                                  Navigator.of(context).pop();
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
                ),
                FButton(
                  title: 'Nhận thức và số câu',
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
                        return SingleChildScrollView(
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter mystate) =>
                                    FBottomSheet(
                              header: FModal(
                                title: FText('Lọc theo nhận thức và số câu',
                                    style: FTextStyle.titleModules3),
                              ),
                              body: Container(
                                padding: EdgeInsets.all(16),
                                color: FColors.grey1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FText('Chọn mức độ nhận thức',
                                        style: FTextStyle.titleModules3),
                                    FRadioButton(
                                      value: 1,
                                      groupValue: selectedRadio,
                                      label: 'Theo từng mức độ nhận thức',
                                      onChanged: (val) {
                                        mystate(() {
                                          selectedRadio = val;
                                        });
                                        filterByLevel = val;
                                        searchStatsTestOutline();
                                        Navigator.of(context).pop();
                                      },
                                      toggle: true,
                                    ),
                                    FRadioButton(
                                      value: 0,
                                      groupValue: selectedRadio,
                                      label: 'Theo các mức độ nhận thức',
                                      onChanged: (val) {
                                        mystate(() {
                                          selectedRadio = val;
                                        });
                                        filterByLevel = val;
                                        searchStatsTestOutline();
                                        Navigator.of(context).pop();
                                      },
                                      toggle: true,
                                    ),
                                    FText('Chọn số lượng câu',
                                        style: FTextStyle.titleModules3),
                                    FRadioButton(
                                      value: 0,
                                      groupValue: selectedRadioTitle,
                                      label: 'Tất cả',
                                      onChanged: (val) {
                                        mystate(() {
                                          selectedRadioTitle = val;
                                        });
                                        rowNumber = val;
                                        searchStatsTestOutline();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FRadioButton(
                                      value: 10,
                                      groupValue: selectedRadioTitle,
                                      label: '10 câu gần nhất',
                                      onChanged: (val) {
                                        mystate(() {
                                          selectedRadioTitle = val;
                                        });
                                        rowNumber = val;
                                        searchStatsTestOutline();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FRadioButton(
                                      value: 5,
                                      groupValue: selectedRadioTitle,
                                      label: '5 câu gần nhất',
                                      onChanged: (val) {
                                        mystate(() {
                                          selectedRadioTitle = val;
                                        });
                                        rowNumber = val;
                                        searchStatsTestOutline();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          isLoading
              ? Expanded(
                  child: StaticNumber.baseShimmer,
                )
              : Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TablePerformancereport(testBlueprintsItems),
                ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    final da = TestOutLineDA();

    final result = await da.getInfo();

    setState(() {
      searchTestOutline = widget.dataTestOutline;
    });

    // ignore: avoid_print
    print(result.code);
  }
}
