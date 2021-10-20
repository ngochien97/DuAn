import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Layout/HeaderBody.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/PhoneNumber.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
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
              'Số điện thoại',
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
          PhoneNumber(),
        ]);
  }
}
