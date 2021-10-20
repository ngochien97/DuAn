import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/ChangePassword.dart';
import 'package:Framework/FIS.SYS/Layout/HeaderBody.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey globalKey = GlobalKey<ScaffoldState>();
  showSuccessMessage(BuildContext context) {
    var profileScreenKey = ModalRoute.of(context).settings.arguments;
    Navigator.pop(context);
    FSnackBar.showSnackBar(
        context,
        FSnackBar(
          key: profileScreenKey,
          content: FText(
            'Đổi mật khẩu thành công',
            color: FColors.grey1,
          ),
          isFloating: true,
          borderRadius: 8,
          backgroundColor: FColors.green6,
          icon: FIcon(
            icon: FFilledIcons.check_circle,
            color: [FColors.grey1, FColors.transparent],
            size: 24.0,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: false).getUserData;
    var userUpdatePassword =
        Provider.of<AuthProvider>(context, listen: false).getUserUpdatePassword;
    var userUpdate = UserUpdatePassword(
        email: user.email,
        oldPassword: userUpdatePassword.oldPassword,
        newPassword: userUpdatePassword.newPassword);
    return Scaffold(
        key: globalKey,
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
              'Đổi mật khẩu',
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
                UserDA.changePassword(
                    context, userUpdate, showSuccessMessage(context));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            ChangePassword(),
          ]),
        ));
  }
}
