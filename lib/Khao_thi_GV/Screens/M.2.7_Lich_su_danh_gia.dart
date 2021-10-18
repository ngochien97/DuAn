import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

class EvaluationHistory extends StatefulWidget {
  @override
  _EvaluationHistoryState createState() => _EvaluationHistoryState();
}

class _EvaluationHistoryState extends State<EvaluationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: FColors.grey3,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                color: FColors.grey1,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FText(
                                'Cô Ngiêm Thùy Linh',
                                style: FTextStyle.titleModules5,
                              ),
                              FText(
                                '12h00 16/12/2020',
                                style: FTextStyle.subtitle2,
                              ),
                            ],
                          ),
                          FIconButton(
                            icon: FOutlinedIcons.up,
                            backgroundColor: FColors.grey1,
                            color: FColors.grey8,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: FText(
                        'Nhận xét chung: Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.',
                        maxLines: 3,
                        style: FTextStyle.titleModules6,
                      ),
                    ),
                    FDivider(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FText(
                                'Tiêu chí 1',
                                style: FTextStyle.subtitle1,
                                color: FColors.grey9,
                              ),
                              FText(
                                'Đã biết cách sắp xếp bố cục bài viết.',
                                style: FTextStyle.subtitle1,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          FTag(
                            title: 'Tốt 75%',
                            backgroundColor: FColors.green2,
                            color: FColors.green6,
                          )
                        ],
                      ),
                    ),
                    FDivider(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FText(
                                  'Tiêu chí 2',
                                  style: FTextStyle.subtitle1,
                                  color: FColors.grey9,
                                ),
                                FText(
                                  'Chưa biết lập luận chặt chẽ, chứng minh thuyết phục',
                                  style: FTextStyle.subtitle1,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          FTag(
                            title: 'Trung bình 50%',
                            backgroundColor: FColors.purple2,
                            color: FColors.purple6,
                          )
                        ],
                      ),
                    ),
                    FDivider(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FText(
                                'Tiêu chí 3',
                                style: FTextStyle.subtitle1,
                                color: FColors.grey9,
                              ),
                              FText(
                                'Làm tốt',
                                style: FTextStyle.subtitle1,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          FTag(
                            title: 'xuất sắc 100%',
                            backgroundColor: FColors.blue2,
                            color: FColors.blue6,
                          )
                        ],
                      ),
                    ),
                    FDivider(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FText(
                                  'Tiêu chí 4',
                                  style: FTextStyle.subtitle1,
                                  color: FColors.grey9,
                                ),
                                FText(
                                  'Chưa biết lập luận chặt chẽ, chứng minh thuyết phục',
                                  style: FTextStyle.subtitle1,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          FTag(
                            title: 'Kém 0%',
                            backgroundColor: FColors.red2,
                            color: FColors.red6,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                color: FColors.grey1,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FText(
                                'Cô Ngiêm Thùy Linh',
                                style: FTextStyle.titleModules5,
                              ),
                              FText(
                                '12h00 16/12/2020',
                                style: FTextStyle.subtitle2,
                              ),
                            ],
                          ),
                          FIconButton(
                            icon: FOutlinedIcons.down,
                            backgroundColor: FColors.grey1,
                            color: FColors.grey8,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: FText(
                        'Nhận xét chung: Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.',
                        maxLines: 3,
                        style: FTextStyle.titleModules6,
                      ),
                    ),
                    FDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
