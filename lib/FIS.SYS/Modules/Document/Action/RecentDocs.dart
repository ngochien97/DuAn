import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FDA/screens.dart';
import 'package:Framework/FIS.SYS/Components/PopupActionSheetBar.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyItem.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:share/share.dart';

class RecentDocs extends StatefulWidget {
  final bool isGridViewMode;
  final SortType sortType;
  final bool isSelectMode;
  final Function moveFile;
  final String fileName;
  final Function selectMode;

  RecentDocs({
    Key key,
    this.isGridViewMode = true,
    this.sortType = SortType.date_desc,
    this.isSelectMode = false,
    this.moveFile,
    this.fileName = '',
    this.selectMode,
  }) : super(key: key);

  @override
  _RecentDocsState createState() => _RecentDocsState();
}

class _RecentDocsState extends State<RecentDocs> {
  bool isSelectMode = false;

  updateSelectMode(bool value) {
    setState(() {
      isSelectMode = value;
    });
  }

  CompanyItem selectedCom;
  bool isLoadingButton = false;
  bool isLoading = true;
  static final storage = new FlutterSecureStorage();
  FileProvider fileProvider;

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  void didUpdateWidget(RecentDocs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sortType != widget.sortType ||
        oldWidget.fileName != widget.fileName) {
      getFiles();
    }
    // Provider.of<FileProvider>(context, listen: false)
    //     .filterListRecent(widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? Container(
            height: 100,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : Consumer<FileProvider>(
            builder: (context, fileProvider, _) => RefreshIndicator(
              onRefresh: () async {
                getFiles();
              },
              child: fileProvider.getListRecent.length == 0
                  ? Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Text("Không có gì để hiển thị"),
                    )
                  : widget.isGridViewMode
                      ? gridView(fileProvider, appWidth)
                      : listView(fileProvider),
            ),
          );
  }

  getFiles() {
    setState(() {
      isLoading = true;
    });
    Provider.of<FileProvider>(context, listen: false).setRecentDocs([]);
    imageCache.clear();
    Timer(Duration(milliseconds: 500), () async {
      setState(() {
        isLoading = false;
      });
      var recentDocs = new List<FileItem>();
      Directory storageDirectory;
      try {
        if (Platform.isAndroid) {
          storageDirectory = await getExternalStorageDirectory();
          var customStorageBaseDirectory =
              "${storageDirectory.path}/my-custom-storage/snapping_pages/";
          Directory(customStorageBaseDirectory).listSync().forEach((el) async {
            recentDocs.add(
              FileItem(
                  isSelected: false,
                  docUri: el.path + "/document_image.jpg",
                  previewDocUri: el.path + "/document_image_preview.jpg",
                  oriDocUri: el.path + "/original_image.jpg",
                  previewOriDocUri: el.path + "/original_image_preview.jpg",
                  filename:
                      "RECENT_${el.statSync().changed.toString().substring(0, 19).replaceAll(RegExp(r"[^\s\w]"), "")}",
                  uploadDate: el.statSync().changed),
            );
          });
        } else if (Platform.isIOS) {
          storageDirectory = await getApplicationDocumentsDirectory();
          var customStorageBaseDirectory =
              "${storageDirectory.path}/my-custom-storage/JPEG/originals/";
          Directory(customStorageBaseDirectory).listSync().forEach((el) {
            if (el.path.contains("_preview")) {
              recentDocs.add(
                FileItem(
                    isSelected: false,
                    docUri: el.path
                        .replaceAll("originals", "documents")
                        .replaceAll("_preview", ""),
                    previewDocUri: el.path.replaceAll("originals", "documents"),
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
        Directory("${storageDirectory.path}/pdffiles/PDF")
            .listSync()
            .forEach((el) {
          recentDocs.add(FileItem());
        });
      } catch (e) {}
      try {
        switch (widget.sortType) {
          case SortType.alphabet_asc:
            recentDocs.sort(
                (a, b) => b.uploadDate.difference(a.uploadDate).inSeconds);
            break;
          case SortType.alphabet_desc:
            recentDocs.sort(
                (a, b) => b.uploadDate.difference(a.uploadDate).inSeconds);
            break;
          case SortType.date_asc:
            recentDocs.sort(
                (a, b) => a.uploadDate.difference(b.uploadDate).inSeconds);
            break;
          case SortType.date_desc:
            recentDocs.sort(
                (a, b) => b.uploadDate.difference(a.uploadDate).inSeconds);
            break;
        }

        Provider.of<FileProvider>(context, listen: false)
            .setRecentDocs(recentDocs);
      } catch (e) {
        Provider.of<FileProvider>(context, listen: false).setRecentDocs([]);
      }
      Provider.of<FileProvider>(context, listen: false)
          .filterListRecent(widget.fileName);
    });
  }

  gridView(FileProvider fileProvider, double appWidth) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            (appWidth < 1000) ? appWidth * 0.5 : appWidth * (1 / 3),
        childAspectRatio: (appWidth < 1000)
            ? (appWidth * 0.5 - 48) / (appWidth * 0.5 + 48)
            : (appWidth * (1 / 3) - 64) / (appWidth * (1 / 3) + 48),
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
      ),
      itemCount: fileProvider.getListRecent.length,
      cacheExtent: 250,
      itemBuilder: (context, index) {
        var doc = fileProvider.getListRecent[index];
        return Container(
          child: FCard(
            hasShadow: false,
            hasPadding: false,
            backgroundColor: FColors.transparent,
            alignment: CrossAxisAlignment.start,
            size: FBoxSize.auto_square,
            avatar: Opacity(
              opacity: widget.isSelectMode && !doc.isSelected ? 0.2 : 1,
              child: Image.file(
                File(doc.previewDocUri),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            title: FText(
              doc.filename,
              style: FTextStyle.titleModules6,
              color: SkinColor.title,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: FText(
              doc.uploadDate.toString().substring(0, 19),
              style: FTextStyle.subtitle2,
              color: SkinColor.subTitle,
            ),
            bottomItems: widget.isSelectMode
                ? FCheckbox(
                    value: doc.isSelected,
                    onChanged: (v) {
                      fileProvider.setSelect(index, v);
                    },
                  )
                : null,
            actionChildren: widget.isSelectMode
                ? null
                : [
                    FIconButton(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      icon: FOutlinedIcons.ellipsis,
                      color: SkinColor.title,
                      backgroundColor: SkinColor.backGroundSearch,
                      size: FIconButtonSize.size24,
                      onPressed: () {
                        showAction(context, doc);
                      },
                    ),
                  ],
            onTap: () {
              if (widget.isSelectMode) {
                fileProvider.setSelect(
                    index, !fileProvider.getListRecent[index].isSelected);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingFileScreen(
                      filename: doc.filename,
                      fileUri: doc.docUri,
                      // .replaceAll("file://", "")
                      //.replaceAll("_preview", ""),
                    ),
                  ),
                );
              }
            },
            onLongPress: () => {
              widget.selectMode(index),
            },
          ),
        );
      },
    );
  }

  listView(FileProvider fileProvider) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: fileProvider.getListRecent.length,
      cacheExtent: 250,
      itemBuilder: (context, index) {
        var doc = fileProvider.getListRecent[index];
        return FListTitle(
          height: 72,
          isSelect: true,
          startItem: widget.isSelectMode
              ? Container(
                  margin: EdgeInsets.only(right: 16),
                  child: FCheckbox(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: doc.isSelected,
                    onChanged: (v) {
                      fileProvider.setSelect(index, v);
                    },
                  ),
                )
              : Container(),
          avatar: FBoundingBox(
            size: FBoxSize.size48x48,
            child: Opacity(
              opacity: widget.isSelectMode && !doc.isSelected ? 0.2 : 1,
              child: Image.file(
                File(doc.previewDocUri),
                fit: BoxFit.cover,
                height: 48,
                width: 48,
              ),
            ),
          ),
          title: FText(
            doc.filename,
            style: FTextStyle.titleModules6,
            color: SkinColor.title,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: FText(
            doc.uploadDate.toString().substring(0, 19),
            style: FTextStyle.subtitle2,
            color: SkinColor.subTitle,
          ),
          action: widget.isSelectMode
              ? null
              : [
                  FIconButton(
                    size: FIconButtonSize.size32,
                    icon: FOutlinedIcons.ellipsis,
                    backgroundColor: FColors.transparent,
                    color: FColors.grey10,
                    onPressed: () {
                      showAction(context, doc);
                    },
                  ),
                ],
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => SettingFileScreen(
          //         fileUri: doc.docUri,
          //         // .replaceAll("file://", "")
          //         //.replaceAll("_preview", ""),
          //       ),
          //     ),
          //   );
          // },
          onTap: () {
            if (widget.isSelectMode) {
              fileProvider.setSelect(
                  index, !fileProvider.getListRecent[index].isSelected);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingFileScreen(
                    fileUri: doc.docUri,
                    filename: doc.filename,
                    // .replaceAll("file://", "")
                    //.replaceAll("_preview", ""),
                  ),
                ),
              );
            }
          },
          onLongPress: () => widget.selectMode(index),
        );
      },
    );
  }

  showAction(BuildContext context, FileItem doc) {
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
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => SafeArea(
          child: FBottomSheet(
            header: FModal(
              title: FText(
                "Tác vụ",
                style: FTextStyle.titleModules3,
              ),
            ),
            body: MediaQuery.of(context).size.height > 824
                ? Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FListTitle(
                          title: FText("Crop ảnh"),
                          height: 48,
                          avatar: FBoundingBox(
                            size: FBoxSize.size32x32,
                            type: FBoundingBoxType.circle,
                            backgroundColor: FColors.green1,
                            child: FIcon(
                              icon: FOutlinedIcons.crop,
                              color: [FColors.green6],
                            ),
                          ),
                          onTap: () {
                            String dir;
                            String pageId;
                            if (Platform.isAndroid) {
                              dir = Directory(doc.docUri).parent.path;
                              pageId =
                                  dir.substring(dir.length - 36, dir.length);
                            } else if (Platform.isIOS) {
                              dir = Directory(doc.docUri).path;
                              pageId = dir.substring(
                                  dir.length - 40, dir.length - 4);
                            }

                            var page = new c.Page(
                              null,
                              null,
                              null,
                              pageId,
                              [
                                c.PolygonPoint(0, 0),
                                c.PolygonPoint(0, 1),
                                c.PolygonPoint(1, 1),
                                c.PolygonPoint(1, 0),
                              ],
                              Uri(path: doc.oriDocUri),
                              Uri(path: doc.docUri),
                              Uri(path: doc.previewOriDocUri),
                              Uri(path: doc.previewDocUri),
                            );
                            Navigator.pop(context);
                            startCropScreen(page);
                          },
                        ),
                        FSpacer.space16px,
                        FListTitle(
                            title: FText("Chia sẻ"),
                            onTap: () {
                              Navigator.pop(context);
                              Share.shareFiles([doc.docUri]);
                            },
                            height: 48,
                            avatar: FBoundingBox(
                                size: FBoxSize.size32x32,
                                type: FBoundingBoxType.circle,
                                backgroundColor: FColors.green1,
                                child: FIcon(
                                  icon: FOutlinedIcons.share_alt,
                                  color: [FColors.green6],
                                ))),
                        FSpacer.space16px,
                        FListTitle(
                          title: FText("Đổi tên"),
                          height: 48,
                          avatar: FBoundingBox(
                            size: FBoxSize.size32x32,
                            type: FBoundingBoxType.circle,
                            backgroundColor: FColors.green1,
                            child: FIcon(
                              icon: FOutlinedIcons.font_colors,
                              color: [FColors.green6],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingFileScreen(
                                  fileUri: doc.docUri
                                      .toString()
                                      .replaceAll("file://", ""),
                                ),
                              ),
                            );
                          },
                        ),
                        FSpacer.space16px,
                        FListTitle(
                          title: FText("Move location"),
                          height: 48,
                          avatar: FBoundingBox(
                            size: FBoxSize.size32x32,
                            type: FBoundingBoxType.circle,
                            backgroundColor: FColors.green1,
                            child: FIcon(
                              icon: FOutlinedIcons.swap,
                              color: [FColors.green6],
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            var docPro = Provider.of<FileProvider>(context,
                                listen: false);
                            docPro.setSelect(
                                docPro.getListRecent.indexOf(doc), true);
                            widget.moveFile();
                          },
                        ),
                        FSpacer.space16px,
                        FListTitle(
                          title: FText("Xoá"),
                          height: 48,
                          avatar: FBoundingBox(
                            size: FBoxSize.size32x32,
                            type: FBoundingBoxType.circle,
                            backgroundColor: FColors.red1,
                            child: FIcon(
                              icon: FFilledIcons.delete,
                              color: [FColors.red6],
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            showDeleteConfirm(context, doc);
                          },
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FListTitle(
                            title: FText("Crop ảnh"),
                            height: 48,
                            avatar: FBoundingBox(
                              size: FBoxSize.size32x32,
                              type: FBoundingBoxType.circle,
                              backgroundColor: FColors.green1,
                              child: FIcon(
                                icon: FOutlinedIcons.crop,
                                color: [FColors.green6],
                              ),
                            ),
                            onTap: () {
                              String dir;
                              String pageId;
                              if (Platform.isAndroid) {
                                dir = Directory(doc.docUri).parent.path;
                                pageId =
                                    dir.substring(dir.length - 36, dir.length);
                              } else if (Platform.isIOS) {
                                dir = Directory(doc.docUri).path;
                                pageId = dir.substring(
                                    dir.length - 40, dir.length - 4);
                              }

                              var page = new c.Page(
                                null,
                                null,
                                null,
                                pageId,
                                [
                                  c.PolygonPoint(0, 0),
                                  c.PolygonPoint(0, 1),
                                  c.PolygonPoint(1, 1),
                                  c.PolygonPoint(1, 0),
                                ],
                                Uri(path: doc.oriDocUri),
                                Uri(path: doc.docUri),
                                Uri(path: doc.previewOriDocUri),
                                Uri(path: doc.previewDocUri),
                              );
                              Navigator.pop(context);
                              startCropScreen(page);
                            },
                          ),
                          FSpacer.space16px,
                          FListTitle(
                              title: FText("Chia sẻ"),
                              onTap: () {
                                Navigator.pop(context);
                                Share.shareFiles([doc.docUri]);
                              },
                              height: 48,
                              avatar: FBoundingBox(
                                  size: FBoxSize.size32x32,
                                  type: FBoundingBoxType.circle,
                                  backgroundColor: FColors.green1,
                                  child: FIcon(
                                    icon: FOutlinedIcons.share_alt,
                                    color: [FColors.green6],
                                  ))),
                          FSpacer.space16px,
                          FListTitle(
                            title: FText("Đổi tên"),
                            height: 48,
                            avatar: FBoundingBox(
                              size: FBoxSize.size32x32,
                              type: FBoundingBoxType.circle,
                              backgroundColor: FColors.green1,
                              child: FIcon(
                                icon: FOutlinedIcons.font_colors,
                                color: [FColors.green6],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingFileScreen(
                                    fileUri: doc.docUri
                                        .toString()
                                        .replaceAll("file://", ""),
                                  ),
                                ),
                              );
                            },
                          ),
                          FSpacer.space16px,
                          FListTitle(
                            title: FText("Move location"),
                            height: 48,
                            avatar: FBoundingBox(
                              size: FBoxSize.size32x32,
                              type: FBoundingBoxType.circle,
                              backgroundColor: FColors.green1,
                              child: FIcon(
                                icon: FOutlinedIcons.swap,
                                color: [FColors.green6],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              var docPro = Provider.of<FileProvider>(context,
                                  listen: false);
                              docPro.setSelect(
                                  docPro.getListRecent.indexOf(doc), true);
                              widget.moveFile();
                            },
                          ),
                          FSpacer.space16px,
                          FListTitle(
                            title: FText("Xoá"),
                            height: 48,
                            avatar: FBoundingBox(
                              size: FBoxSize.size32x32,
                              type: FBoundingBoxType.circle,
                              backgroundColor: FColors.red1,
                              child: FIcon(
                                icon: FFilledIcons.delete,
                                color: [FColors.red6],
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              showDeleteConfirm(context, doc);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Container(
          //       height: 56,
          //       decoration: BoxDecoration(
          //         color: FColors.grey1,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(12),
          //           topRight: Radius.circular(12),
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           FIconButton(
          //             color: FColors.grey10,
          //             icon: FOutlinedIcons.close,
          //             backgroundColor: FColors.transparent,
          //             buttonStyle: FIconButtonStyle.iconAction,
          //             size: FIconButtonSize.size48,
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //           ),
          //           Expanded(
          //             child: Container(
          //               alignment: Alignment.center,
          //               child: FText(
          //                 "Tác vụ",
          //                 style: FTextStyle.titleModules3,
          //               ),
          //             ),
          //           ),
          //           Container(
          //             width: 48,
          //           ),
          //         ],
          //       ),
          //     ),

          //   ],
          // ),
        ),
      ),
    );
  }

  showDeleteConfirm(BuildContext context, FileItem doc) {
    // showFPopupActionSheet(
    //     context,
    //     FPopupActionSheet(
    //         backgroundColor: FColors.grey3,
    //         borderRadius: BorderRadius.circular(8),
    //         margin: EdgeInsets.all(16),
    //         padding: EdgeInsets.all(16),
    //         message: FText(
    //           "Những files này sẽ bị xóa khỏi kho dữ liệu chung, trên tất cả các thiết bị của bạn",
    //           textAlign: TextAlign.center,
    //         ),
    //         actions: [
    //           FPopupAction(
    //             title: "Xoá",
    //             color: FColors.red6,
    //             onPressed: () async {
    //               try {
    //                 if (Platform.isAndroid) {
    //                   Directory(doc.previewOriDocUri)
    //                       .parent
    //                       .deleteSync(recursive: true);
    //                 } else if (Platform.isIOS) {
    //                   var imgFolder = [
    //                     "originals",
    //                     "documents",
    //                     "unfilteredDocuments",
    //                   ];
    //                   var dir = doc.previewOriDocUri;

    //                   for (var item in imgFolder) {
    //                     try {
    //                       Directory(dir.replaceAll("originals", item))
    //                           .deleteSync(recursive: true);
    //                       Directory(dir
    //                               .replaceAll("originals", item)
    //                               .replaceAll("_preview", ""))
    //                           .deleteSync(recursive: true);
    //                     } catch (e) {
    //                       print(e);
    //                     }
    //                   }
    //                 }
    //                 Navigator.pop(context);
    //                 getFiles();
    //               } catch (e) {
    //                 print(e);
    //               }
    //             },
    //           ),
    //           FPopupAction(
    //             title: "Huỷ",
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           )
    //         ]));
    showModalBottomSheet(
      backgroundColor: FColors.transparent,
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FColors.grey3,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FText(
              "Những files này sẽ bị xóa khỏi kho dữ liệu chung, trên tất cả các thiết bị của bạn",
              textAlign: TextAlign.center,
            ),
            FSpacer.space8px,
            FListTitle(
                title: FText(
                  "Xoá",
                  style: FTextStyle.titleModules3,
                  color: FColors.red6,
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  try {
                    if (Platform.isAndroid) {
                      Directory(doc.previewOriDocUri)
                          .parent
                          .deleteSync(recursive: true);
                    } else if (Platform.isIOS) {
                      var imgFolder = [
                        "originals",
                        "documents",
                        "unfilteredDocuments",
                      ];
                      var dir = doc.previewOriDocUri;

                      for (var item in imgFolder) {
                        try {
                          Directory(dir.replaceAll("originals", item))
                              .deleteSync(recursive: true);
                          Directory(dir
                                  .replaceAll("originals", item)
                                  .replaceAll("_preview", ""))
                              .deleteSync(recursive: true);
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                    Navigator.pop(context);
                    getFiles();
                  } catch (e) {
                    print(e);
                  }
                }),
            FSpacer.space8px,
            FListTitle(
              onTap: () {
                Navigator.pop(context);
              },
              title: FText(
                "Huỷ",
                style: FTextStyle.titleModules3,
                color: FColors.blue6,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  startCropScreen(c.Page page) async {
    MethodChannel _channel = const MethodChannel('scanbot_sdk');
    try {
      String result = await _channel.invokeMethod("startCroppingScreen", {
        "topBarTitle": "Crop file",
        "cancelButtonTitle": "Huỷ",
        "doneButtonTitle": "Lưu",
        "page": page.toJson(),
      });
      var data = CroppingResult.fromJson(jsonDecode(result));
      if (data.operationResult == c.OperationResult.SUCCESS) {
        getFiles();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingFileScreen(
              fileUri: data.page.documentImageFileUri
                  .toString()
                  .replaceAll("file://", ""),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

enum SortType {
  alphabet_asc,
  alphabet_desc,
  date_asc,
  date_desc,
}
