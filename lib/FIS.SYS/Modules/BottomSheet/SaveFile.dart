import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

saveFile(BuildContext context) {
  // CompanyDA.getCompanies(context);
  int checkSelected;
  showModalBottomSheet(
    context: context,
    builder: (context) => FBottomSheet(
      header: FModal(
        title: FText(
          'Lưu trữ file',
          style: FTextStyle.buttonText1,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: FListTitle(
              title: FText('Folder hiện tại'),
              subtitle: FText('Recent'),
              round: true,
              avatar: FBoundingBox(
                backgroundColor: FColors.green2,
                size: FBoxSize.size32x32,
                child: FIcon(
                  color: [FColors.green6, FColors.transparent],
                  size: 20,
                  icon: FFilledIcons.folder_open,
                ),
              ),
            ),
          ),
          Container(
            child: Consumer<CompanyProvider>(
              builder: (context, companyProvider, child) => Column(
                children: [
                  for (var company in companyProvider.getListCompany)
                    GestureDetector(
                      onTap: () {},
                      child: FListTitle(
                        title: FText(company.companyName),
                        subtitle: FText(
                          "${company.numFileDone.toString()} ${company.numFileDone == 1 ? "File" : "Files"}",
                          style: FTextStyle.subtitle2,
                        ),
                        avatar: FBoundingBox(
                          size: FBoxSize.size48x48,
                          child: Image.memory(
                            convert.base64Decode(company.avatarBase64
                                .replaceFirst("data:image/png;base64,", "")),
                          ),
                        ),
                        dividerIndent: true,
                        action: [
                          FRadioButton(
                              value: company.numFileDone,
                              onChanged: (value) {},
                              groupValue: checkSelected)
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            color: FColors.grey1,
            padding: EdgeInsets.all(16),
            child: FButton(
              title: 'Move',
              backgroundColor: FColors.green6,
              color: FColors.grey1,
              size: FButtonSize.size40,
              onPressed: null,
              block: true,
            ),
          ),
        ],
      ),
    ),
  );
}
