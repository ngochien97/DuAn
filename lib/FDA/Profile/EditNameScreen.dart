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
import 'package:Framework/FIS.SYS/Modules/User/Action/EditName.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  UserDA userDA = UserDA();

  String validateMessage = '';
  String fullName;
  bool isChange = false;

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
            disableBackgroundColor: FColors.transparent,
            onPressed: isChange
                ? () async {
                    if (fullName == '' || fullName == null) {
                      setState(() {
                        validateMessage = "Tên người dùng không thể để trống";
                      });
                    } else {
                      validateMessage = null;
                    }

                    if (validateMessage == null) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setNewUser(
                        UserItem(
                          userId:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .userId,
                          fullName: fullName,
                          email:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .email,
                          phoneNumber:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .phoneNumber,
                          orgId:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .orgId,
                          avatarBase64:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .avatarBase64,
                        ),
                      );
                      UserItem userItem =
                          Provider.of<UserProvider>(context, listen: false)
                              .getNewUser;
                      try {
                        var data = await userDA.updateInfo(userItem);
                        if (data.statusCode == 200) {
                          var user = await userDA.getInfo();
                          if (user.statusCode == 200) {
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(user.userItem);
                          }
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
                                'Đổi tên thành công',
                                color: FColors.grey1,
                              ),
                              borderRadius: 8.0,
                              backgroundColor: FColors.green6,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                            ),
                          );
                        } else {
                          print(data.statusCode);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    // UserDA.updateInfo(userItem);
                  }
                : null,
          )
        ],
      ),
      body: EditName(
        validateMessage: validateMessage,
        onChangeName: onChangeName,
      ),
    );
  }

  onChangeName(String value) {
    setState(() {
      fullName = value;
      isChange = true;
    });
  }
}
