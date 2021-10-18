import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/AppBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Actions/ListView.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';

class ExamManagement extends StatefulWidget {
  @override
  _ExamManagementState createState() => _ExamManagementState();
}

class _ExamManagementState extends State<ExamManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.grey2,
      appBar: FAppBar(
        backgroundColor: FColors.grey1,
        brightness: Brightness.light,
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Quản lý thi',
            style: FTextStyle.titleModules3,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        color: FColors.grey3,
        child: Column(
          children: [
            Container(
              color: FColors.grey1,
              padding: EdgeInsets.only(left: 8, top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageScreen()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FText(
                          'Trình quản lý thi',
                          style: FTextStyle.titleModules3,
                        ),
                        FText(
                          '15 kíp thi',
                          style: FTextStyle.subtitle2,
                          color: SkinColor.secondary,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset('lib/FIS.SYS/Assets/images/quanlythi.svg')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              color: FColors.grey1,
              padding: EdgeInsets.only(left: 8, top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FText(
                          'Chấm thi',
                          style: FTextStyle.titleModules3,
                        ),
                        FText(
                          '120 bài làm',
                          style: FTextStyle.subtitle2,
                          color: SkinColor.secondary,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset('lib/FIS.SYS/Assets/images/chamthi.svg')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
