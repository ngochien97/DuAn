import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/ListTitle.dart';
import 'package:Framework/FIS.SYS/Components/Switch.dart';
import 'package:Framework/FIS.SYS/Components/Tag.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class ListTitleScreen extends StatelessWidget {
  const ListTitleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List title"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            FListTitle(
              title: FText("List title", style: FTextStyle.bodyText1),
              subtitle: FText("Subtitle", style: FTextStyle.subtitle2),
              avatar: FBoundingBox(
                child: SizedBox(),
                size: FBoxSize.size16x16,
                type: FBoundingBoxType.circle,
                backgroundColor: FColors.blue3,
              ),
              action: [
                FTag(title: "First tag"),
                FSwitch(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: true,
                  onChanged: (v) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
