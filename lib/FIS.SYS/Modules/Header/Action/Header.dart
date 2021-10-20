import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/Filter.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

FAppBar appBarInDocs(BuildContext context) {
  return FAppBar(
    headerLead: FButton(
      buttonStyle: FButtonStyle.textAction,
      leftIcon: FOutlinedIcons.left,
      title: "Trang chủ",
      backgroundColor: Colors.transparent,
      color: SkinColor.titleBack,
      size: FButtonSize.size48,
      block: true,
      onPressed: () {
        Navigator.pop(context);
      },
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
        onPressed: () {
          filter(context);
        },
      ),
    ],
  );
}
