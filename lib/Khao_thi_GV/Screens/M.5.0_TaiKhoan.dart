import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/User/Actions/Infor.dart';
import '../../FIS.SYS/Modules/User/UserItem.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';

class InforScreen extends StatefulWidget {
  @override
  _InforScreenState createState() => _InforScreenState();
}

class _InforScreenState extends State<InforScreen> {
  UserItem user = UserItem();
  final storage = FlutterSecureStorage();

  Future getInfor() async {
    final userStore = await storage.read(key: 'userInfo');
    setState(() {
      user = UserItem.fromJson(json.decode(userStore));
    });
  }

  @override
  void initState() {
    getInfor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: FAppBar(
        headerLead: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12),
              child: FBoundingBox(
                backgroundColor: FColors.transparent,
                size: FBoxSize.size40x40,
                child: Image.asset('lib/FIS.SYS/Assets/images/ava.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FText(
                    '${user.fullName}',
                    style: FTextStyle.titleModules6,
                  ),
                  FText(
                    'Profiles',
                    style: FTextStyle.subtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: UserInfor());
}
