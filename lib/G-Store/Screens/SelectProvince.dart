import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:Framework/FIS.SYS/Modules/ChooseCity/Action/ChooseCity.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class SelectProvince extends StatefulWidget {
  @override
  _SelectProvinceState createState() => _SelectProvinceState();
}

class _SelectProvinceState extends State<SelectProvince> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: FAppBar(
          headerActions: [
            Container(
              child: FButton(
                title: 'Xong',
                color: FColors.blue6,
                onPressed: () {},
                backgroundColor: FColors.grey1,
              ),
            ),
          ],
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Chọn tỉnh thành',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerLead: Row(
            children: [
              Container(
                child: FIconButton(
                  icon: FOutlinedIcons.left,
                  size: FIconButtonSize.size24,
                  onPressed: () {},
                  backgroundColor: FColors.grey1,
                  color: FColors.grey10,
                ),
              ),
            ],
          ),
          bottom: FTextField(
            label: 'Tìm tên tỉnh thành',
            leftIcon: FOutlinedIcons.search,
            backgroundColor: FColors.grey3,
            size: FTextFieldSize.size40,
            rightIcon: FOutlinedIcons.microphone,
          ),
        ),
        body: Container(
          child: ChooserCity(),
        ),
      ),
    );
  }
}
