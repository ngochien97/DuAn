import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

import '../../../../../F.Utils/Convert.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Skins/Icon.dart';
import '../../../../Skins/KhaoThi/SkinColor.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/StyleBase.dart';
import '../../ClassInfomation.dart';
import '../../DA/ClassDA.dart';
import '../../DA/TakerGroupDA.dart';
import '../../Provider/TestTakerProvider.dart';
import '../../TakerGroup.dart';
import '../../TakerGroupStatus.dart';
import '../../TakerGroupSummary.dart';
import '../chart/BarChartInDetailManage.dart';
import '../chart/ChartCircleHashCode.dart';
import '../chart/ChartInDetailManage.dart';
import 'TableClassInTakerGroup.dart';
import 'TableTopicInTakerGroup.dart';

class OverView extends StatefulWidget {
  final TakerGroup takerGroup;
  final void Function() callBack;
  const OverView(this.takerGroup, {this.callBack});
  @override
  _ProctorState createState() => _ProctorState();
}

class _ProctorState extends State<OverView> {
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;
  TakerGroupSummary takerGroupSummary;
  ClassDA classDA = ClassDA();
  ChartCirHashCode chartHashcode = ChartCirHashCode.withSampleData();
  @override
  void initState() {
    takerGroupDA.getSummary(widget.takerGroup.id).then((value) async {
      if (value.code == 200) {
        setState(() {
          takerGroupSummary = value.takerGroupSummary;
        });

        final classes = await classDA.getInfo();
        if (classes.code == 200) {
          final classStr = <ClassInfomation>[];
          final testTakerProvider =
              Provider.of<TestTakerProvider>(context, listen: false);
          final data = takerGroupSummary;

          //lay ma lop
          for (final item in takerGroupSummary.takerClasses) {
            final found = classes.classes.firstWhere(
              (element) => element.id == item.testTakerClassId,
              orElse: () => null,
            );
            if (found != null) {
              item.testTakerClassName = found.name;
              classStr.add(found);
            }
          }

          await testTakerProvider.setClass(classStr);

          // lay ma de
          final formCodes = <Tuple2<String, bool>>[];
          if (takerGroupSummary.fromDatas != null) {
            for (final item in takerGroupSummary.fromDatas) {
              formCodes.add(Tuple2<String, bool>(item.testFormCode, false));
            }
          }

          await testTakerProvider.setFormCodes(formCodes);
          setState(() {
            takerGroupSummary = data;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return takerGroupSummary == null
        ? OverViewLoading()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: <Widget>[
              Container(
                color: FColors.grey1,
                child: Column(children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const FText(
                          'Gói đề:',
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: Container(
                            child: FText(
                              '${widget.takerGroup.name}',
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FDivider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const FText(
                          'Giờ mở kíp:',
                          textAlign: TextAlign.center,
                        ),
                        FText(
                          '${widget.takerGroup.getStringTimeOpen}',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  const FDivider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    height: 48,
                    child: Row(
                      children: <Widget>[
                        const FText(
                          'Giờ đóng kíp:',
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        FText(
                          '${widget.takerGroup.toTime.format("dd/MM/yyyy HH:mm")}',
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              FSpacer.space16px,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.callBack();
                      },
                      child: FListTitle(
                        height: 48,
                        avatar: const FBoundingBox(
                          backgroundColor: FColors.transparent,
                          child: FIcon(
                            icon: FFilledIcons.user_multiple,
                            color: [
                              SkinColor.primary,
                            ],
                          ),
                        ),
                        title: const FText('Thí sinh'),
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
                      avatar: const FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.paper_diploma,
                          color: [
                            SkinColor.primary,
                          ],
                        ),
                      ),
                      title: const FText('Điểm trung bình'),
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
                      avatar: const FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.scale,
                          color: [
                            SkinColor.primary,
                          ],
                        ),
                      ),
                      title: const FText('Độ lệch chuẩn'),
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
                      avatar: const FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.user_time,
                          color: [
                            SkinColor.primary,
                          ],
                        ),
                      ),
                      title: const FText('Chưa thi'),
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
                      avatar: const FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.user_edit,
                          color: [
                            SkinColor.primary,
                          ],
                        ),
                      ),
                      title: const FText('Đang thi'),
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
                      avatar: const FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.user_check,
                          color: [
                            SkinColor.primary,
                          ],
                        ),
                      ),
                      title: const FText('Đã thi'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                    takerGroupSummary.testTakerMarkHistogram !=
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
                                                MainAxisAlignment.spaceBetween,
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.9),
                                          ),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                    takerGroupSummary.testTakerMarkHistogram !=
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 350,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.9),
                                          ),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                child: tableInClass(takerGroupSummary.takerClasses,
                    'testTakerClassName', context),
              ),
              FSpacer.space16px,
              Container(
                color: FColors.grey1,
                child: tableInTopic(takerGroupSummary.fromDatas),
              )
            ]),
          );
  }

  String getTimeOpen() {
    return '';
  }
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
    Provider.of<TestTakerProvider>(context, listen: false)
        .setActiveStatus(value == null ? null : int.parse(value));
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
        const Text(
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
        padding: const EdgeInsets.all(16),
        height: 350,
        decoration: const BoxDecoration(
            color: FColors.grey1,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: FColors.grey1),
                    ),
                  ),
                  const Expanded(
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
                            Provider.of<TestTakerProvider>(context,
                                    listen: false)
                                .loadData(widget.id);
                            Navigator.pop(context);
                          },
                          child: const FText(
                            'Xong',
                            color: SkinColor.primary,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const Divider(),
            ...buildFilterStatus(),
          ],
        ),
      );
}

class OverViewLoading extends StatelessWidget {
  const OverViewLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 150,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: FColors.grey1,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 22,
                            width: 100,
                            color: Colors.white,
                          ),
                          Container(
                            height: 22,
                            width: 200,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FDivider(),
                ],
              ),
            ),
          ),
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
                            width: 60,
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
        ],
      ),
    );
  }
}
