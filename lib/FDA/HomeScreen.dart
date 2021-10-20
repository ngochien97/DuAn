import 'package:Framework/FIS.SYS/Layout/Full.dart';
import 'package:Framework/FIS.SYS/Modules/BottomTab/Action/BottomTab.dart';
import 'package:Framework/FIS.SYS/Modules/Company/Action/ListView.dart';
import 'package:Framework/FIS.SYS/Modules/Header/HomeHeader.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FullLayout(
        backGround: FColors.grey3,
        appBar: homeHeader(context),
        body: [ListCompany()],
        bottom: SafeArea(child: BottomTabBar()));
  }
}
