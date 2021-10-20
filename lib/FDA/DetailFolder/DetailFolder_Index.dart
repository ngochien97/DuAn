import 'package:Framework/FIS.SYS/Layout/Full.dart';
import 'package:Framework/FIS.SYS/Modules/BottomTab/Action/BottomTab.dart';
import 'package:Framework/FIS.SYS/Modules/Header/Action/Header.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/ListView.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:flutter/material.dart';

class DetailFolderIndex extends StatefulWidget {
  @override
  _DetailFolderIndexState createState() => _DetailFolderIndexState();
}

class _DetailFolderIndexState extends State<DetailFolderIndex> {
  @override
  Widget build(BuildContext context) {
    return FullLayout(
      backGround: SkinColor.backGround,
      appBar: appBarInDocs(context),
      body: [
        ListDocs(),
      ],
      bottom: BottomTabBar(),
    );
  }
}
