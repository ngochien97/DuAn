import 'package:Framework/FDA/Providers/DocumentProvider.dart';

import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Row.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../DocumentDA.dart';
import 'More.dart';

class ListDocs extends StatefulWidget {
  @override
  _ListDocsState createState() => _ListDocsState();
}

class _ListDocsState extends State<ListDocs> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> name = ModalRoute.of(context).settings.arguments;
    final sort = Provider.of<DocumentProvider>(context, listen: false).getSort;
    DocumentDA.getDocument(context, name["comEmail"], '1', '10', sort);

    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FRow(
          children: [
            FColumn(
              columnType: FColumnType.col_100,
              child: FText(
                name["title"],
                style: FTextStyle.bodyText1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Consumer<DocumentProvider>(
          builder: (context, documentProvider, child) => FRow(
            children: [
              FColumn(
                columnType: FColumnType.col_100,
                child: documentProvider.getDocuments.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: Text('Không có gì để hiện thị'),
                          ),
                        ],
                      )
                    : Container(),
              ),
              for (var doc in documentProvider.getDisplayDocuments)
                FColumn(
                  columnType:
                      (width <= 1000) ? FColumnType.col_50 : FColumnType.col_25,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 24),
                    child: FCard(
                      hasShadow: false,
                      backgroundColor: SkinColor.backTransparent,
                      alignment: CrossAxisAlignment.start,
                      hasPadding: false,
                      size: FBoxSize.auto_square,
                      topItems: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FTag(
                          title: doc.status['text'],
                          color: doc.status['color'],
                          backgroundColor: doc.status['backGround'],
                          dottedBorder: false,
                          leftIcon: doc.status['icon'],
                        ),
                      ),
                      avatar: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'lib/FIS.SYS/Assets/images/ImgDocs.png',
                          fit: BoxFit.cover,
                          height: 183,
                          width: 183,
                        ),
                      ),
                      title: FText(
                        doc.name,
                        style: FTextStyle.bodyText2,
                        color: SkinColor.title,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: FText(
                        doc.userUpdateId,
                        style: FTextStyle.subtitle2,
                        color: SkinColor.subTitle,
                      ),
                      content: FText(
                        doc.lastUpdate,
                        style: FTextStyle.subtitle2,
                        color: SkinColor.subTitle,
                      ),
                      actionChildren: [
                        FIconButton(
                          icon: FOutlinedIcons.ellipsis,
                          color: SkinColor.title,
                          backgroundColor: SkinColor.backGroundSearch,
                          size: FIconButtonSize.size24,
                          onPressed: () {
                            more(context);
                          },
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
