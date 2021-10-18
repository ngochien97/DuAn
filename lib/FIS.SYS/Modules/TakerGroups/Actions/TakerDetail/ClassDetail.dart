import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Components/ComponentsBase.dart';
import '../../../../Components/Text.dart';
import '../../../../Skins/Icon.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/Colors.dart';
import '../../../../Styles/Icons.dart';
import '../../../../Styles/Spacer.dart';
import '../../../../Styles/StyleBase.dart';
import '../../DA/ClassDA.dart';
import '../../DA/TakerGroupDA.dart';
import '../../Provider/TestTakerProvider.dart';
import '../../TakerGroup.dart';
import '../../TakerGroupModelSummary.dart';
import '../../TakerGroupStatus.dart';
import '../../TakerGroupSummary.dart';
import '../../TestTaker.dart';
import '../chart/BarChartInDetailManage.dart';
import '../chart/ChartCircleHashCode.dart';
import '../chart/ChartInDetailManage.dart';
import 'StudentInClass.dart';
import 'TableTopicInTakerGroup.dart';

class ClassDetailView extends StatefulWidget {
  final int classId;
  final int groupId;
  final String className;

  final void Function() callBack;
  const ClassDetailView(this.classId, this.groupId, this.className,
      {this.callBack});
  @override
  _ClassDetailViewState createState() => _ClassDetailViewState();
}

class _ClassDetailViewState extends State<ClassDetailView> {
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;
  // TakerGroupSummary takerGroupSummary;
  TakerGroupSummaryModel takerGroupSummaryModel;
  TakerGroupSummary takerGroupSummary;
  List<TestTaker> testTakers;
  TakerGroup takerGroup;
  bool isLoading = false;

  ClassDA classDA = ClassDA();
  final chartHashcode = ChartCirHashCode.withSampleData();
  Future<void> getData() async {
    takerGroupSummaryModel =
        await takerGroupDA.classGetSumary(widget.classId, widget.groupId);
    if (takerGroupSummaryModel.code == 200) {
      setState(() {
        takerGroupSummary = takerGroupSummaryModel.takerGroupSummary;
        testTakers = takerGroupSummaryModel.testTakers;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? ClassDetailLoading()
      : takerGroupSummary == null
          ? Center(
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
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: <Widget>[
                FSpacer.space16px,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.callBack();
                        },
                        child: FListTitle(
                          height: 48,
                          avatar: FBoundingBox(
                            backgroundColor: FColors.transparent,
                            child: FIcon(
                              icon: FFilledIcons.user_multiple,
                              color: const <Color>[
                                FColors.blue6,
                              ],
                            ),
                          ),
                          title: FText('Thí sinh'),
                          action: [
                            FText(
                              '${takerGroupSummary.testTakerStatusTotal ?? "-"}',
                              textAlign: TextAlign.right,
                            )
                          ],
                        ),
                      ),
                      FSpacer.space8px,
                      FListTitle(
                        height: 48,
                        avatar: FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.paper_diploma,
                            color: const <Color>[
                              FColors.blue6,
                            ],
                          ),
                        ),
                        title: FText('Điểm trung bình'),
                        action: [
                          FText(
                            '${takerGroupSummary.testTakerMarkAvgDone ?? "-"}',
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      FSpacer.space8px,
                      FListTitle(
                        height: 48,
                        avatar: FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.scale,
                            color: const <Color>[
                              FColors.blue6,
                            ],
                          ),
                        ),
                        title: FText('Độ lệch chuẩn'),
                        action: [
                          FText(
                            '${takerGroupSummary.testTakerMarkStdDev ?? "-"}',
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      FSpacer.space8px,
                      FListTitle(
                        height: 48,
                        avatar: FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.user_time,
                            color: const <Color>[
                              FColors.blue6,
                            ],
                          ),
                        ),
                        title: FText('Chưa thi'),
                        action: [
                          FText(
                            '${takerGroupSummary.testTakerStatusTodo ?? "-"}',
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      FSpacer.space8px,
                      FListTitle(
                        height: 48,
                        avatar: FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.user_edit,
                            color: const <Color>[
                              FColors.blue6,
                            ],
                          ),
                        ),
                        title: FText('Đang thi'),
                        action: [
                          FText(
                            '${takerGroupSummary.testTakerStatusDoing ?? "-"}',
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      FSpacer.space8px,
                      FListTitle(
                        height: 48,
                        avatar: FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.user_check,
                            color: const <Color>[
                              FColors.blue6,
                            ],
                          ),
                        ),
                        title: FText('Đã thi'),
                        action: [
                          FText(
                            '${takerGroupSummary.testTakerStatusDone ?? "-"}',
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                FSpacer.space16px,
                Container(
                  color: FColors.grey1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  FText(
                                    'Thống kê mức độ đạt chuẩn',
                                    style: FTextStyle.titleModules5,
                                  )
                                ],
                              ),
                              (takerGroupSummary != null &&
                                      takerGroupSummary
                                              .testTakerMarkHistogram !=
                                          null &&
                                      takerGroupSummary
                                          .testTakerMarkHistogram.isNotEmpty)
                                  ? Row(
                                      children: <Widget>[
                                        infoChart(),
                                        Expanded(
                                            flex: 2,
                                            child: ChartInDetailMg(
                                                datas: takerGroupSummary
                                                    .testTakerMarkHistogram)),
                                      ],
                                    )
                                  : Container(
                                      height: 200,
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                infoHashCode(),
                                                Expanded(
                                                    flex: 2,
                                                    child: ChartCirHashCode(
                                                        chartHashcode
                                                            .seriesList)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.9),
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  boxShadow: [
                                                    FEffect.elevation1
                                                  ],
                                                  color: FColors.grey1,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: FText(
                                                  'Chưa có dữ liệu',
                                                  style:
                                                      FTextStyle.titleModules4,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                FSpacer.space16px,
                Container(
                  color: FColors.grey1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  FText(
                                    'Phổ điểm',
                                    style: FTextStyle.titleModules5,
                                  )
                                ],
                              ),
                              (takerGroupSummary != null &&
                                      takerGroupSummary
                                              .testTakerMarkHistogram !=
                                          null &&
                                      takerGroupSummary
                                          .testTakerMarkHistogram.isNotEmpty)
                                  ? Container(
                                      color: FColors.grey1,
                                      height: 350,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                              child: SimpleBarChart(
                                                  datas: takerGroupSummary
                                                      .testTakerMarkHistogram)),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      color: FColors.grey1,
                                      height: 350,
                                      child: Stack(
                                        children: <Widget>[
                                          SimpleBarChart(
                                            datas: const <Map<int, int>>[],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 350,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.9),
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  boxShadow: [
                                                    FEffect.elevation1
                                                  ],
                                                  color: FColors.grey1,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: FText(
                                                  'Chưa có dữ liệu',
                                                  style:
                                                      FTextStyle.titleModules4,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: FColors.grey1,
                  child: tableInTopic(takerGroupSummary.fromDatas),
                ),
                FSpacer.space16px,
                Container(
                  color: FColors.grey1,
                  child: studentInClass(testTakers, context),
                ),
                FSpacer.space16px,
              ]),
            );
}

class BottomSheetWitchStatus extends StatefulWidget {
  final int id;

  const BottomSheetWitchStatus(this.id);

  @override
  _BottomSheetWitchStatus createState() => _BottomSheetWitchStatus();
}

class _BottomSheetWitchStatus extends State<BottomSheetWitchStatus> {
  //Initial definition of radio button value
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
    lst.add(Row(
      children: <Widget>[
        Radio(
          value: null,
          groupValue: provider.status == null ? null : '${provider.status}',
          onChanged: radioButtonChanges,
        ),
        Text(
          'Tất cả',
        ),
      ],
    ));
    for (final item in testTakerStatus.keys) {
      //  var color = item.item2 ? CusColors.blue6 : CusColors.grey6;
      lst.add(Row(
        children: <Widget>[
          Radio(
            value: '$item',
            groupValue: '${provider.status}',
            onChanged: radioButtonChanges,
          ),
          Text(testTakerStatus[item]),
        ],
      ));
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16),
        height: 350,
        decoration: BoxDecoration(
            color: FColors.grey1,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: FColors.grey1),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: FText(
                        'Lọc theo trạng thái',
                        color: FColors.grey9,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                    child: Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            final provider = Provider.of<TestTakerProvider>(
                                context,
                                listen: false);
                            provider.loadData(widget.id);
                            Navigator.pop(context);
                          },
                          child: FText(
                            'Xong',
                            color: FColors.blue6,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Divider(),
            ...buildFilterStatus(),
          ],
        ),
      );
}

class ClassDetailLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          height: 340,
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) => Column(
              children: [
                FListTitle(
                  height: 50,
                  title: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Row(
                      children: [
                        FBoundingBox(
                          type: FBoundingBoxType.circle,
                          child: Container(color: Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          height: 20,
                          width: 70,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  action: [
                    Container(
                      height: 20,
                      width: 60,
                      color: Colors.white,
                    ),
                  ],
                ),
                FSpacer.space8px
              ],
            ),
          ),
        ),
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
