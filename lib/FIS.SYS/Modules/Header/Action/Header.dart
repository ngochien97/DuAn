import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/RecentDocs.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FAppBar appBarInDocs(
  BuildContext context, {
  String comName,
  String screen = 'document',
  bool isGridViewMode,
  SortType sortType,
  Function onChangeViewMode,
  Function onChangeSort,
  String comEmail,
}) {
  return FAppBar(
    headerLead: Container(
      margin: EdgeInsets.only(left: 8),
      child: FButton(
        buttonStyle: FButtonStyle.textAction,
        leftIcon: FOutlinedIcons.left,
        title: "Trang chủ",
        backgroundColor: Colors.transparent,
        color: SkinColor.titleBack,
        size: FButtonSize.size40,
        block: true,
        onPressed: () {
          Provider.of<CompanyProvider>(context, listen: false)
              .setCurrentCompany(null);
          Navigator.pop(context);
        },
      ),
    ),
    headerActions: [
      FIconButton(
        icon: FOutlinedIcons.search,
        color: SkinColor.title,
        backgroundColor: FColors.transparent,
        size: FIconButtonSize.size48,
        onPressed: () {
          Navigator.pushNamed(context, '/search', arguments: {
            "screen": screen,
            "comEmail": comEmail,
          });
          print(comEmail);
        },
      ),
      FIconButton(
        icon: isGridViewMode ? FOutlinedIcons.paragraph : FOutlinedIcons.grid,
        color: SkinColor.title,
        backgroundColor: FColors.transparent,
        size: FIconButtonSize.size48,
        onPressed: () {
          onChangeViewMode();
        },
      ),
      FIconButton(
        icon: FOutlinedIcons.sort_ascending,
        color: SkinColor.title,
        backgroundColor: FColors.transparent,
        size: FIconButtonSize.size48,
        onPressed: () {
          showAction(context, sortType, onChangeSort);
        },
      ),
    ],
    bodyTitle: FText(
      comName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: FTextStyle.bodyText1,
      fontWeight: FontWeight.w600,
    ),
  );
}

showAction(BuildContext context, SortType sortType, Function onChangeSort) {
  showModalBottomSheet(
    elevation: 0,
    isDismissible: true,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SafeArea(
        child: FBottomSheet(
          header: FModal(
            title: FText(
              "Sắp xếp",
              style: FTextStyle.titleModules3,
            ),
          ),
          body: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 2),
                FListTitle(
                  title: FText("Mới nhất"),
                  height: 48,
                  round: false,
                  backgroundColor: FColors.grey1,
                  action: sortType == SortType.date_desc
                      ? [
                          FIcon(
                            icon: FOutlinedIcons.check,
                            color: [FColors.blue6],
                            size: 16,
                          )
                        ]
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onChangeSort(SortType.date_desc);
                  },
                ),
                FListTitle(
                  title: FText("Cũ nhất"),
                  height: 48,
                  round: false,
                  backgroundColor: FColors.grey1,
                  action: sortType == SortType.date_asc
                      ? [
                          FIcon(
                            icon: FOutlinedIcons.check,
                            color: [FColors.blue6],
                            size: 16,
                          )
                        ]
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onChangeSort(SortType.date_asc);
                  },
                ),
                FListTitle(
                  title: FText("Theo tên (từ A đến Z)"),
                  height: 48,
                  round: false,
                  backgroundColor: FColors.grey1,
                  action: sortType == SortType.alphabet_asc
                      ? [
                          FIcon(
                            icon: FOutlinedIcons.check,
                            color: [FColors.blue6],
                            size: 16,
                          )
                        ]
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onChangeSort(SortType.alphabet_asc);
                  },
                ),
                FListTitle(
                  title: FText("Theo tên (từ Z đến A)"),
                  height: 48,
                  round: false,
                  backgroundColor: FColors.grey1,
                  action: sortType == SortType.alphabet_desc
                      ? [
                          FIcon(
                            icon: FOutlinedIcons.check,
                            color: [FColors.blue6],
                            size: 16,
                          )
                        ]
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onChangeSort(SortType.alphabet_desc);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
