import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showImportScreen(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (context) => FBottomSheet(
        header: FModal(
          title: FText(
            'Import',
            style: FTextStyle.buttonText1,
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: FListTitle(
                  avatar: FBoundingBox(
                    backgroundColor: FColors.green1,
                    child: FIcon(
                      icon: FFilledIcons.picture,
                      color: [FColors.green6, FColors.transparent],
                      size: 20,
                    ),
                    size: FBoxSize.size32x32,
                    type: FBoundingBoxType.circle,
                  ),
                  title: FText(
                    'Import từ photo',
                    style: FTextStyle.titleModules6,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: FListTitle(
                avatar: FBoundingBox(
                  backgroundColor: FColors.green1,
                  child: FIcon(
                    icon: FFilledIcons.picture,
                    color: [FColors.green6, FColors.transparent],
                    size: 20,
                  ),
                  size: FBoxSize.size32x32,
                  type: FBoundingBoxType.circle,
                ),
                title: FText(
                  'Import từ photo',
                  style: FTextStyle.titleModules6,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
