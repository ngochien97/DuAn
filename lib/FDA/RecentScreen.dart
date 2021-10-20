import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Layout/HeaderBody.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBodyLayout(
      appBar: FAppBar(
        headerLead: FButton(
          size: FButtonSize.size48,
          leftIcon: FOutlinedIcons.close,
          onPressed: () {
            Navigator.pop(context);
          },
          title: "Đóng",
          backgroundColor: FColors.transparent,
          color: FColors.blue6,
          block: true,
        ),
        headerActions: [
          FIconButton(
            icon: FOutlinedIcons.search,
            color: SkinColor.title,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          FIconButton(
            icon: FOutlinedIcons.check_square,
            color: SkinColor.title,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {},
          ),
          FIconButton(
            icon: FOutlinedIcons.paragraph,
            color: SkinColor.title,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {},
          ),
          FIconButton(
            icon: FOutlinedIcons.sort_ascending,
            color: SkinColor.title,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {},
          ),
        ],
        bodyTitle: FText("Recent"),
      ),
      body: [
        Container(),
      ],
    );
  }
}
