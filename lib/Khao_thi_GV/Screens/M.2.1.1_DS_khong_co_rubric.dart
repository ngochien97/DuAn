import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/AppBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

class NotRubric extends StatefulWidget {
  @override
  _NotRubricState createState() => _NotRubricState();
}

class _NotRubricState extends State<NotRubric> {
  String searchValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Đánh giá',
            style: FTextStyle.titleModules3,
          ),
        ),
        headerActions: [Container(width: 24)],
        headerLead: FIconButton(
          icon: FOutlinedIcons.left,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: FColors.grey1,
          color: FColors.grey9,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 12),
          color: FColors.grey3,
          child: Column(
            children: [
              Container(
                color: FColors.grey1,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          FText(
                            'Lớp dành cho học sinh có năng khiếu đặc biệt',
                            style: FTextStyle.titleModules6,
                            maxLines: 2,
                          ),
                          FText(
                            '15 học sinh',
                            style: FTextStyle.subtitle2,
                          )
                        ],
                      ),
                    ),
                    FTag(
                      title: '0 Rubric',
                      color: FColors.orange6,
                      backgroundColor: FColors.orange2,
                      leftIcon: FOutlinedIcons.close,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: FColors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(top: 24.0),
                            child: SingleChildScrollView(
                              child: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter mystate) {
                                return FBottomSheet(
                                  mainAxisSize: MainAxisSize.max,
                                  header: FModal(
                                    title: FText('Thêm Rubric',
                                        style: FTextStyle.titleModules3),
                                    textAction: FButton(
                                      size: FButtonSize.size40,
                                      title: 'xong',
                                      color: FColors.blue6,
                                      backgroundColor: FColors.grey1,
                                      onPressed: () {},
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  body: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(16),
                                    color: FColors.grey1,
                                    child: FTextField(
                                      label: 'Tìm theo tên/mã Rubric',
                                      value: searchValue,
                                      size: FTextFieldSize.size40,
                                      leftIcon: FOutlinedIcons.search,
                                      onChanged: () {},
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                        'lib/FIS.SYS/Assets/images/danhgia.svg')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
