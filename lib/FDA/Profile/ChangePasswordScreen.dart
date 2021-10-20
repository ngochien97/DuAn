import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/ChangePassword.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  UserDA userDA = UserDA();
  String oldPassword;
  String newPassword1;
  String newPassword2;

  String oldPasswordMessage;
  String newPasswordMessage1;
  String newPasswordMessage2;
  showSuccessMessage(BuildContext context) async {
    Navigator.pop(context);
    showFSnackBar(
      context,
      FSnackBar(
        position: FlushbarPosition.TOP,
        icon: FIcon(
          icon: FFilledIcons.check_circle,
          color: [FColors.grey1, FColors.transparent],
          size: 24.0,
        ),
        message: FText(
          'Đổi mật khẩu thành công',
          color: FColors.grey1,
        ),
        borderRadius: 8.0,
        backgroundColor: FColors.green6,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }

  onHandleChangePassword(BuildContext context) async {
    UserItem newUser =
        Provider.of<UserProvider>(context, listen: false).getNewUser;
    if (oldPassword == '' || oldPassword == null) {
      setState(() {
        oldPasswordMessage = "Vui lòng nhập mật khẩu";
      });
    } else {
      setState(() {
        oldPasswordMessage = null;
      });
    }

    if (newPassword1 == '' || newPassword1 == null) {
      setState(() {
        newPasswordMessage1 = "Vui lòng nhập mật khẩu mới";
      });
    } else {
      setState(() {
        newPasswordMessage1 = null;
      });
    }

    if (newPassword2 == '' || newPassword2 == null) {
      setState(() {
        newPasswordMessage2 = "Vui lòng nhập mật khẩu mới";
      });
    } else if (newPassword2 != newPassword1) {
      setState(() {
        newPasswordMessage2 = "Mật khẩu mới không trùng khớp";
      });
    } else {
      setState(() {
        newPasswordMessage2 = null;
      });
    }

    if (oldPasswordMessage == null &&
        newPasswordMessage1 == null &&
        newPasswordMessage2 == null) {
      UserItem user = Provider.of<UserProvider>(context, listen: false).getUser;
      Provider.of<UserProvider>(context, listen: false).setNewUser(
        UserItem(
          email: user.email,
          password: oldPassword,
          newPassword: newPassword1,
        ),
      );
      try {
        var data = await userDA.changePassword(newUser);
        if (data.statusCode == 200) {
          showSuccessMessage(context);
        } else {
          setState(() {
            oldPasswordMessage = 'Mật khẩu không đúng';
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onHandleChangePassword(context);

              FocusScope.of(context).unfocus();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ChangePassword(
            oldPasswordMessage: oldPasswordMessage,
            newPasswordMessage1: newPasswordMessage1,
            newPasswordMessage2: newPasswordMessage2,
            onChangeOldPassword: onChangeOldPassword,
            onChangeNewPassword1: onChangeNewPassword1,
            onChangeNewPassword2: onChangeNewPassword2,
          ),
        ]),
      ),
    );
  }

  void onChangeOldPassword(String value) {
    setState(() {
      oldPassword = value;
    });
  }

  void onChangeNewPassword1(String value) {
    setState(() {
      newPassword1 = value;
    });
  }

  void onChangeNewPassword2(String value) {
    setState(() {
      newPassword2 = value;
    });
  }
}
