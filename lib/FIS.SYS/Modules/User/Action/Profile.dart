import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/State/Building.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    UserDA userDA = UserDA();
    var data = await userDA.getInfo();
    Provider.of<UserProvider>(context, listen: false).setUser(data.userItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: FCard(
            alignment: CrossAxisAlignment.center,
            avatar: Consumer<UserProvider>(
              builder: (context, userProvider, child) => Image.memory(
                convert.base64Decode(userProvider.getUser.avatarBase64
                    .replaceFirst("data:image/png;base64,", "")),
              ),
            ),
            size: FBoxSize.size40x40,
            title: Consumer<UserProvider>(
              builder: (context, userProvider, child) => FText(
                userProvider.getUser.fullName,
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuildingScreen()));
                },
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              GestureDetector(
                child: FListTitle(
                  hasShadow: false,
                  avatar: FBoundingBox(
                    backgroundColor: FColors.green1,
                    type: FBoundingBoxType.round,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      icon: FFilledIcons.user,
                      color: [FColors.green6],
                    ),
                  ),
                  title: FText('Tên đầy đủ'),
                  action: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          userProvider.getUser.fullName,
                          style: FTextStyle.bodyText2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
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
                  hasShadow: false,
                  avatar: FBoundingBox(
                    backgroundColor: FColors.blue1,
                    type: FBoundingBoxType.round,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      icon: FFilledIcons.mail,
                      color: [SkinColor.titleBack],
                    ),
                  ),
                  title: FText('Email'),
                  action: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          userProvider.getUser.email,
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
                  Navigator.of(context).pushNamed('Email_screen');
                },
              ),
              GestureDetector(
                child: FListTitle(
                  hasShadow: false,
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
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: FText(
                          userProvider.getUser.phoneNumber,
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
                  hasShadow: false,
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
                  Navigator.of(context).pushNamed('ChangePassword_screen');
                },
              ),
              // GestureDetector(
              //   child: FListTitle(
              //     avatar: FBoundingBox(
              //       backgroundColor: FColors.geek_blue1,
              //       type: FBoundingBoxType.round,
              //       size: FBoxSize.size32x32,
              //       child: FIcon(
              //         icon: FFilledIcons.question_circle,
              //         color: [FColors.geek_blue6],
              //       ),
              //     ),
              //     title: FText('Hướng dẫn sử dụng'),
              //     action: [
              //       FIcon(
              //         icon: FOutlinedIcons.right,
              //         color: [FColors.grey7],
              //       ),
              //     ],
              //   ),
              //   onTap: () {},
              // ),
              FSpacer.space24px,
              GestureDetector(
                child: FListTitle(
                  hasShadow: false,
                  avatar: FBoundingBox(
                    backgroundColor: FColors.volcano1,
                    type: FBoundingBoxType.round,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      icon: FFilledIcons.engine_start,
                      color: [FColors.volcano6],
                    ),
                  ),
                  title: FText('Đăng xuất'),
                  action: [
                    FIcon(
                      icon: FOutlinedIcons.right,
                      color: [FColors.grey7],
                    ),
                  ],
                ),
                onTap: () {
                  storage.delete(key: 'token');
                  Navigator.pushNamedAndRemoveUntil(
                      context, "login_screen", (route) => false);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
