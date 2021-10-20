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
  String searchValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.grey3,
      appBar: homeHeader(
        context,
        searchValue,
        onChangeSearchValue,
      ),
      body: ListCompany(onRefresh: onRefresh),
      bottomNavigationBar: BottomTabBar(),
    );
  }

  void onRefresh() {
    setState(() {
      searchValue = '';
    });
  }

  void onChangeSearchValue(String value) {
    setState(() {
      searchValue = value;
    });
  }
}
