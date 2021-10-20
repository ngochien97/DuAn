import 'package:Framework/FIS.SYS/Modules/BottomTab/Action/BottomTab.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/RecentDocs.dart';
import 'package:Framework/FIS.SYS/Modules/Files/Action/ListView.dart';
import 'package:Framework/FIS.SYS/Modules/Header/Action/Header.dart';
import 'package:flutter/material.dart';

class DetailFolderIndex extends StatefulWidget {
  @override
  _DetailFolderIndexState createState() => _DetailFolderIndexState();
}

class _DetailFolderIndexState extends State<DetailFolderIndex> {
  bool isGridViewMode = true;
  SortType sortType = SortType.date_desc;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarInDocs(
        context,
        comName: args["title"],
        comEmail: args["comEmail"],
        isGridViewMode: isGridViewMode,
        sortType: sortType,
        onChangeViewMode: () {
          setState(() {
            isGridViewMode = !isGridViewMode;
          });
        },
        onChangeSort: (SortType value) {
          setState(() {
            sortType = value;
          });
        },
      ),
      body: ListFile(
        sortType: sortType,
        isGridViewMode: isGridViewMode,
        comEmail: args["comEmail"],
      ),
      bottomNavigationBar: BottomTabBar(),
    );
  }
}
