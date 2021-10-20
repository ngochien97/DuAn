import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/Button.dart';
import 'package:Framework/FIS.SYS/Components/IconButton.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/QR_code/Home.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: FAppBar(
          headerCenter: FText(
            'Khai báo thông tin',
            style: FTextStyle.buttonText1,
          ),
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            backgroundColor: FColors.grey1,
            color: FColors.grey9,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Họ và tên',
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Ngày sinh',
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Số điện thoại',
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Nơi làm việc',
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Nơi cư trú',
                ),
                SizedBox(height: 12),
                Container(
                  child: FText(
                    'Thông tin tiêm vaccine',
                    style: FTextStyle.titleModules3,
                  ),
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Địa điểm tiêm',
                ),
                SizedBox(height: 12),
                FTextField(
                  size: FTextFieldSize.size56,
                  label: 'Thời gian tiêm',
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: FButton(
                    title: 'Hoàn thành ',
                    backgroundColor: FColors.green6,
                    color: FColors.grey9,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeQR()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
