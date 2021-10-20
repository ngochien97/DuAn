import 'package:Framework/FIS.SYS/Modules/User/Action/Profile.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileGlobalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: profileGlobalKey,
      appBar: FAppBar(
        headerLead: FIconButton(
          icon: FOutlinedIcons.close,
          size: FIconButtonSize.size48,
          backgroundColor: FColors.transparent,
          color: FColors.grey9,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Profile',
            style: FTextStyle.titleModules3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Profile(profileKey: profileGlobalKey),
        ]),
      ),
    );
  }
}
