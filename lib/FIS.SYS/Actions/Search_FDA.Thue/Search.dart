import 'dart:io';
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/RecentDocs.dart';
import 'package:Framework/FIS.SYS/Modules/Files/Action/ListView.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileDA.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileItem.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static final storage = new FlutterSecureStorage();
  var searchController = TextEditingController();
  Map<String, String> headers;
  String searchName;
  bool search = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: SkinColor.backGround,
      appBar: FAppBar(
        backgroundColor: SkinColor.backGround,
        bottom: FTextField(
          controller: searchController,
          backgroundColor: SkinColor.backGroundSearch,
          autoFocus: true,
          size: FTextFieldSize.size40,
          leftIcon: FOutlinedIcons.search,
          label: "Tìm tài liệu",
          value: searchName,
          onChanged: (value) {
            setState(() {
              searchName = value;
              search = value != '' || value == null ? true : false;
            });
            Provider.of<FileProvider>(context, listen: false)
                .filterListRecent(value);
          },
          clearable: searchName == '' || searchName == null ? false : true,
        ),
        bottomAction: FButton(
          backgroundColor: SkinColor.backTransparent,
          block: true,
          title: "Cancel",
          onPressed: () async {
            setState(() {
              searchName = '';
              search = false;
            });
            if (arguments['screen'] == 'document') {
              var docDA = new FileDA();
              var fileProvider =
                  Provider.of<FileProvider>(context, listen: false);
              var result = await docDA.getFiles("1", "10",
                  arguments['comEmail'], searchName, "uploadDate:desc");
              fileProvider.setListDocs(result.fileItems);
            } else {
              Provider.of<FileProvider>(context, listen: false)
                  .setRecentDocs([]);
              imageCache.clear();
              var recentDocs = new List<FileItem>();
              Directory storageDirectory;
              try {
                if (Platform.isAndroid) {
                  storageDirectory = await getExternalStorageDirectory();
                  var customStorageBaseDirectory =
                      "${storageDirectory.path}/my-custom-storage/snapping_pages/";
                  Directory(customStorageBaseDirectory)
                      .listSync()
                      .forEach((el) {
                    recentDocs.add(
                      FileItem(
                          isSelected: false,
                          docUri: el.path + "/document_image.jpg",
                          previewDocUri:
                              el.path + "/document_image_preview.jpg",
                          oriDocUri: el.path + "/original_image.jpg",
                          previewOriDocUri:
                              el.path + "/original_image_preview.jpg",
                          filename:
                              "RECENT_${el.statSync().changed.toString().substring(0, 19).replaceAll(RegExp(r"[^\s\w]"), "")}",
                          uploadDate: el.statSync().changed),
                    );
                  });
                } else if (Platform.isIOS) {
                  storageDirectory = await getApplicationDocumentsDirectory();
                  var customStorageBaseDirectory =
                      "${storageDirectory.path}/my-custom-storage/JPEG/originals/";
                  Directory(customStorageBaseDirectory)
                      .listSync()
                      .forEach((el) {
                    if (el.path.contains("_preview")) {
                      recentDocs.add(
                        FileItem(
                            isSelected: false,
                            docUri: el.path
                                .replaceAll("originals", "documents")
                                .replaceAll("_preview", ""),
                            previewDocUri:
                                el.path.replaceAll("originals", "documents"),
                            oriDocUri: el.path.replaceAll("_preview", ""),
                            previewOriDocUri: el.path,
                            filename:
                                "RECENT_${el.statSync().changed.toString().substring(0, 19).replaceAll(RegExp(r"[^\s\w]"), "")}",
                            uploadDate: el.statSync().changed),
                      );
                    }
                  });
                } else {
                  throw ("Unsupported platform");
                }
              } catch (e) {}

              recentDocs.sort(
                  (a, b) => b.uploadDate.difference(a.uploadDate).inSeconds);

              Provider.of<FileProvider>(context, listen: false)
                  .setRecentDocs(recentDocs);
              Provider.of<FileProvider>(context, listen: false)
                  .filterListRecent('');
            }
            Navigator.pop(context);
          },
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: SkinColor.titleBack,
        ),
      ),
      body: search
          ? arguments['screen'] == 'document'
              ? ListFile(
                  isGridViewMode: false,
                  comEmail: arguments['comEmail'],
                  filename: searchName,
                )
              : RecentDocs(
                  isGridViewMode: false,
                  fileName: searchName,
                  // moveFile: ,
                )
          : Container(),
    );
  }

  getToken() async {
    var token = await storage.read(key: "token");
    headers = {"token": token};
  }
}
