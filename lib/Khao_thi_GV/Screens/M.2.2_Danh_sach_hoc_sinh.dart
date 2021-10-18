import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/AppBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/BottomSheet.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Button.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Checkbox.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/IconButton.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/TextField.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.2.3_Tac_vu.dart';

class ListStudent extends StatefulWidget {
  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  String searchValue;
  bool valueCheck = false;
  List<Map<String, dynamic>> data = [
    {
      'name': 'Phạm Hoàng Ngọc Anh',
      'date': '16/12/2020',
      'tag1': '2/6',
      'tag2': '6.00',
      'isCheck': false
    },
    {
      'name': 'Phạm Hoàng Ngọc áda',
      'date': '16/12/2020',
      'tag1': '6/6',
      'tag2': '6.00',
      'isCheck': false
    },
  ];

  @override
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FText(
                            'Tiểu học - Phẩm chất chăm học, chăm làm',
                            style: FTextStyle.titleModules6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          FText(
                            'Mã: TTNNJJ',
                            style: FTextStyle.subtitle2,
                            color: FColors.blue6,
                          )
                        ],
                      ),
                    ),
                    FButton(
                      title: 'Thay đổi',
                      backgroundColor: FColors.grey1,
                      color: FColors.blue6,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: FColors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.only(top: 24.0),
                              child: SingleChildScrollView(
                                child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter mystate) {
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(16),
                                      color: FColors.grey1,
                                      child: FTextField(
                                        label: 'Tìm tên Rubric',
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FText(
                          'Danh sách học sinh',
                          style: FTextStyle.bodyText1,
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    Column(
                      children: [
                        for (var item in data)
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(16),
                            color: FColors.grey1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Upload()));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FText(
                                            item['name'],
                                            style: FTextStyle.buttonText2,
                                            maxLines: 2,
                                          ),
                                          FText(
                                            'Ngày sinh: ${item['date']}',
                                            style: FTextStyle.subtitle2,
                                          )
                                        ],
                                      ),
                                    ),
                                    FCheckbox(
                                      value: item['isCheck'],
                                      onChanged: (val) {
                                        setState(() {
                                          item['isCheck'] = !item['isCheck'];
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FTag(
                                      title:
                                          '${item['tag1']} tiêu chí đã đánh giá',
                                      backgroundColor: item['tag1'] == '6/6'
                                          ? FColors.green2
                                          : FColors.orange2,
                                      color: item['tag1'] == '6/6'
                                          ? FColors.green6
                                          : FColors.orange6,
                                    ),
                                    FTag(
                                      title: 'Điểm ${item['tag2']}',
                                      backgroundColor: FColors.red2,
                                      color: FColors.red6,
                                      leftIcon: FOutlinedIcons.star,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: FButton(
          title: 'Đánh giá tất cả',
          block: true,
          backgroundColor: FColors.blue6,
          color: FColors.grey1,
          leftIcon: FOutlinedIcons.edit,
          onPressed: () {},
          size: FButtonSize.size40,
        ),
      ),
    );
  }
}
