import 'package:Framework/FDA/Models/Document.dart';
import 'package:Framework/FDA/Providers/DocumentProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    List<Document> documents =
        Provider.of<DocumentProvider>(context).getDocuments;
    String searchName;
    return Scaffold(
      backgroundColor: SkinColor.backGround,
      appBar: FAppBar(
        backgroundColor: SkinColor.backGround,
        bottom: FTextField(
          backgroundColor: SkinColor.backGroundSearch,
          size: FTextFieldSize.size40,
          leftIcon: FOutlinedIcons.search,
          label: "Tìm tài liệu",
          rightIcon: FFilledIcons.microphone,
          value: searchName,
          onSubmitted: (value) {
            searchName = value;
            documents = documents
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchName.toLowerCase()))
                .toList();

            Provider.of<DocumentProvider>(context, listen: false)
                .setDisplayDocuments(documents);
            Navigator.pop(context);
          },
        ),
        bottomAction: FButton(
          backgroundColor: SkinColor.backTransparent,
          block: true,
          title: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: SkinColor.titleBack,
        ),
      ),
    );
  }
}
