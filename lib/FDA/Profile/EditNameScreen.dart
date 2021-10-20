import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/EditName.dart';
import 'package:Framework/FIS.SYS/Layout/HeaderBody.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).getDisplayUserData;
    return HeaderBodyLayout(
      appBar: FAppBar(
        headerLead: FIconButton(
          size: FIconButtonSize.size48,
          icon: FOutlinedIcons.left,
          backgroundColor: FColors.transparent,
          color: FColors.grey10,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Đổi tên',
            style: FTextStyle.titleModules3,
          ),
        ),
        headerActions: [
          FButton(
            title: 'Lưu',
            backgroundColor: FColors.transparent,
            size: FButtonSize.size40,
            block: true,
            color: SkinColor.subTitle,
            onPressed: () {
              UserDA.updateAccountData(user, context);
            },
          )
        ],
      ),
      body: [
        EditName(),
      ],
    );
  }
}
