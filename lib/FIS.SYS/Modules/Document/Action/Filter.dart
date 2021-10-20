import 'package:Framework/FDA/Providers/DocumentProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

filter(BuildContext context) {
  //void
  return FBottomSheet.showFBottomSheet(
    context,
    FBottomSheet(
      enableDrag: false,
      header: FModal(
        title: FText(
          'Sắp xếp',
          style: FTextStyle.buttonText1,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer<DocumentProvider>(
          builder: (context, documentProvider, child) => Column(
            children: [
              GestureDetector(
                onTap: () {
                  documentProvider.reverseSortByTime();
                  Navigator.pop(context);
                },
                child: FListTitle(
                  dividerIndent: true,
                  title: FText('Mới nhất'),
                  action: [
                    FIcon(
                      icon: FOutlinedIcons.check,
                      color: [SkinColor.titleBack, FColors.transparent],
                      size: 16,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  documentProvider.sortByTime();
                  Navigator.pop(context);
                },
                child: FListTitle(
                  dividerIndent: true,
                  title: FText('Cũ nhất'),
                  action: [],
                ),
              ),
              GestureDetector(
                onTap: () {
                  documentProvider.sortByName();
                  Navigator.pop(context);
                },
                child: FListTitle(
                  dividerIndent: true,
                  title: FText('Theo tên ( từ A đến Z)'),
                  action: [],
                ),
              ),
              GestureDetector(
                onTap: () {
                  documentProvider.reverseSortByName();
                  Navigator.pop(context);
                },
                child: FListTitle(
                  title: FText('Theo tên ( từ Z đến A)'),
                  action: [],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
