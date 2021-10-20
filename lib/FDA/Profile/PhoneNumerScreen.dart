import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/PhoneNumber.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String validateMessage;
  String phoneNumber;
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    // User user =
    //     Provider.of<AuthProvider>(context, listen: false).getDisplayUserData;
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
            disableBackgroundColor: FColors.transparent,
            onPressed: isChange
                ? () async {
                    if (phoneNumber == '' || phoneNumber == null) {
                      setState(() {
                        validateMessage = "Vui lòng nhập số điện thoại";
                      });
                    } else if (phoneNumber.length < 10 ||
                        phoneNumber.length > 13) {
                      setState(() {
                        validateMessage = "Số điện thoại không hợp lệ";
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
                          fullName:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .fullName,
                          email:
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .email,
                          phoneNumber: phoneNumber,
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
                      UserDA userDA = UserDA();
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
                                'Đổi sô điện thoại thành công',
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
                  }
                : null,
          )
        ],
      ),
      body: PhoneNumber(
        validateMessage: validateMessage,
        onChangePhoneNumber: onChangePhoneNumber,
      ),
    );
  }

  onChangePhoneNumber(String value) {
    setState(() {
      phoneNumber = value;
      isChange = true;
    });
  }
}
