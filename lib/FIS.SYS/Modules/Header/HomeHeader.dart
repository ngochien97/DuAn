import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FAppBar homeHeader(
  BuildContext context,
  String searchValue,
  Function onChangeSearchValue,
) {
  UserDA userDA = UserDA();
  TextEditingController _controller = new TextEditingController();

  return FAppBar(
    bodyTitle: FText(
      'FIS FDA',
      style: FTextStyle.titleModules2,
    ),
    avatar: FBoundingBox(
      type: FBoundingBoxType.circle,
      backgroundColor: FColors.green6,
      size: FBoxSize.size32x32,
      child: FIconButton(
        icon: FFilledIcons.user,
        color: FColors.grey1,
        size: FIconButtonSize.size32,
        onPressed: () async {
          var data = await userDA.getInfo();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(data.userItem);
          Navigator.pushNamed(context, 'profile_screen');
        },
        backgroundColor: FColors.transparent,
      ),
    ),
    bottom: FTextField(
      controller: _controller,
      label: "Tìm tên công ty",
      leftIcon: FOutlinedIcons.search,
      backgroundColor: FColors.grey3,
      size: FTextFieldSize.size40,
      value: searchValue,
      onChanged: (value) {
        // searchValue = value;
        // onChangeSearchValue(value);
        Provider.of<CompanyProvider>(context, listen: false).filterList(value);
      },
      // clearable: searchValue == '' || searchValue == null ? false : true,
      clearable: true,
    ),
  );
}
