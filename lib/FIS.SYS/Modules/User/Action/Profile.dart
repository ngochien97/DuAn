import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final profileKey;

  Profile({this.profileKey});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    UserDA.getAccountData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: FCard(
            alignment: CrossAxisAlignment.center,
            avatar: Image.asset("lib/FIS.SYS/Assets/images/ava.png"),
            size: FBoxSize.size40x40,
            title: Consumer<AuthProvider>(
              builder: (context, authProvider, child) => FText(
                authProvider.getUserData.fullName,
                style: FTextStyle.titleModules3,
              ),
            ),
            actionChildren: [
              GestureDetector(
                child: FText(
                  'Đổi ảnh đại diện',
                  style: FTextStyle.subtitle2,
                  color: FColors.green6,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              GestureDetector(
                child: FListTitle(
                  avatar: FBoundingBox(
                      backgroundColor: FColors.green1,
                      type: FBoundingBoxType.round,
                      size: FBoxSize.size32x32,
                      child: FIcon(
                        icon: FFilledIcons.user,
                        color: [FColors.green6],
                      )),
                  title: FText('Tên đầy đủ'),
                  action: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          authProvider.getDisplayUserData.fullName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: FTextStyle.bodyText2,
                          color: FColors.grey7,
                        ),
                      ),
                    ),
                    FIcon(
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('EditName_screen');
                },
              ),
              GestureDetector(
                child: FListTitle(
                  avatar: FBoundingBox(
                      backgroundColor: FColors.blue1,
                      type: FBoundingBoxType.round,
                      size: FBoxSize.size32x32,
                      child: FIcon(
                        icon: FFilledIcons.mail,
                        color: [SkinColor.titleBack],
                      )),
                  title: FText('Email'),
                  action: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          authProvider.getUserData.email,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: FTextStyle.bodyText2,
                          color: FColors.grey7,
                        ),
                      ),
                    ),
                    FIcon(
                      size: 16,
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('Email_screen');
                },
              ),
              GestureDetector(
                child: FListTitle(
                  avatar: FBoundingBox(
                      backgroundColor: FColors.red1,
                      type: FBoundingBoxType.round,
                      size: FBoxSize.size32x32,
                      child: FIcon(
                        icon: FFilledIcons.phone,
                        color: [FColors.red6],
                      )),
                  title: FText('Số điện thoại'),
                  action: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          authProvider.getDisplayUserData.phoneNumber,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: FTextStyle.bodyText2,
                          color: FColors.grey7,
                        ),
                      ),
                    ),
                    FIcon(
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('PhoneNumber_screen');
                },
              ),
              GestureDetector(
                child: FListTitle(
                  avatar: FBoundingBox(
                      backgroundColor: FColors.volcano1,
                      type: FBoundingBoxType.round,
                      size: FBoxSize.size32x32,
                      child: FIcon(
                        icon: FFilledIcons.lock,
                        color: [FColors.volcano6],
                      )),
                  title: FText('Đổi mật khẩu'),
                  action: [
                    FIcon(
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('ChangePassword_screen',
                      arguments: widget.profileKey);
                },
              ),
              GestureDetector(
                child: FListTitle(
                  avatar: FBoundingBox(
                    backgroundColor: FColors.geek_blue1,
                    type: FBoundingBoxType.round,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      icon: FFilledIcons.question_circle,
                      color: [FColors.geek_blue6],
                    ),
                  ),
                  title: FText('Hướng dẫn sử dụng'),
                  action: [
                    FIcon(
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
