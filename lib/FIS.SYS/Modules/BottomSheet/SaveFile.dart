import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

void saveFile(BuildContext context) {
  CompanyDA.getCompanies(context);
  int checkSelected;
  return FBottomSheet.showFBottomSheet(
      context,
      FBottomSheet(
        initialChildSize: 0.95,
        enableDrag: false,
        header: FModal(
          title: FText(
            'Lưu trữ file',
            style: FTextStyle.buttonText1,
          ),
          centerTitle: true,
          textAction: SizedBox(
            width: 20,
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
                    for (var company in companyProvider.getCompanies)
                      GestureDetector(
                        onTap: () {},
                        child: FListTitle(
                          title: FText(company.companyName),
                          subtitle: FText(
                            "${company.documentNumber.toString()} ${company.documentNumber == 1 ? "File" : "Files"}",
                            style: FTextStyle.subtitle2,
                          ),
                          avatar: FBoundingBox(
                            size: FBoxSize.size48x48,
                            child: Image.memory(
                              convert.base64Decode(company.avatar
                                  .replaceFirst("data:image/png;base64,", "")),
                            ),
                          ),
                          dividerIndent: true,
                          action: [
                            FRadioButton(
                                value: company.documentNumber,
                                onChanged: (value) {},
                                groupValue: checkSelected)
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottom: Container(
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
      ));
}
