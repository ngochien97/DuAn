import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/BottomSheet/SaveFile.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

editFileName(BuildContext context) => showModalBottomSheet(
      context: context,
      backgroundColor: FColors.transparent,
      elevation: 0,
      builder: (context) => FBottomSheet(
        header: FModal(
          title: FText(
            'Sửa tên file',
            style: FTextStyle.buttonText1,
          ),
          textAction: FButton(
            title: 'Lưu',
            backgroundColor: FColors.transparent,
            block: true,
            color: FColors.grey6,
            size: FButtonSize.size40,
            onPressed: () {
              saveFile(context);
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: FTextField(
            label: 'Tên files',
            value: 'Photo 4 28/11/2020.pdf',
            size: FTextFieldSize.size40,
          ),
        ),
      ),
    );
