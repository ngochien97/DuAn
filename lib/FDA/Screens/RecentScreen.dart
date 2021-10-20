import 'dart:io';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FIS.SYS/Components/PopupActionSheetBar.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Components/ToolBar.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyItem.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/RecentDocs.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RecentScreen extends StatefulWidget {
  RecentScreen({Key key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  bool isLoadingButton = false;
  bool isSelectMode = false;
  bool isGridViewMode = true;
  String screen = 'recent';
  SortType sortType = SortType.date_desc;
  FileProvider fileProvider;
  CompanyItem selectedCom;
  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fileProvider = Provider.of<FileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSelectMode ? selectModeAppBar() : normalModeAppBar(),
      body: RecentDocs(
        isGridViewMode: isGridViewMode,
        isSelectMode: isSelectMode,
        sortType: sortType,
        moveFile: () {
          showChooseCompany(context);
        },
        selectMode: (int index) {
          setState(() {
            isSelectMode = true;
          });
          Provider.of<FileProvider>(context, listen: false)
              .setSelect(index, true);
        },
      ),
      bottomNavigationBar: isSelectMode
          ? Consumer<FileProvider>(
              builder: (context, docPro, child) {
                var isActionAble = fileProvider.getListRecent
                        .where((el) => el.isSelected)
                        .length >
                    0;
                return FToolBar(
                  children: [
                    FToolBarItem(
                      title: 'Xóa',
                      color: FColors.blue6,
                      onTap: isActionAble
                          ? () {
                              showDeleteConfirm(context, fileProvider);
                            }
                          : null,
                    ),
                    FToolBarItem(
                      title: 'Move',
                      color: FColors.blue6,
                      onTap: isActionAble
                          ? () {
                              showChooseCompany(context);
                            }
                          : null,
                    )
                  ],
                );
              },
            )
          : null,
    );
  }

  selectModeAppBar() {
    return FAppBar(
      headerLead: Container(
        margin: EdgeInsets.only(left: 8),
        child: FButton(
          title: "Chọn tất cả",
          leftIcon: FOutlinedIcons.check_square,
          buttonStyle: FButtonStyle.textAction,
          backgroundColor: FColors.transparent,
          color: FColors.blue6,
          block: true,
          onPressed: () {
            for (int i = 0; i < fileProvider.getListRecent.length; i++) {
              fileProvider.setSelect(i, true);
            }
          },
          size: FButtonSize.size40,
        ),
      ),
      headerActions: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: FButton(
            title: "Cancel",
            buttonStyle: FButtonStyle.textAction,
            backgroundColor: FColors.transparent,
            color: FColors.blue6,
            block: true,
            onPressed: () {
              setState(() {
                isSelectMode = !isSelectMode;
              });
              for (int i = 0; i < fileProvider.getListRecent.length; i++) {
                fileProvider.setSelect(i, false);
              }
            },
            size: FButtonSize.size40,
          ),
        )
      ],
      bodyTitle: FText("Recent", style: FTextStyle.largeTitle1),
    );
  }

  normalModeAppBar() {
    return FAppBar(
      backgroundColor: FColors.grey1,
      headerLead: Container(
        margin: EdgeInsets.only(left: 8),
        child: FButton(
          size: FButtonSize.size40,
          leftIcon: FOutlinedIcons.close,
          onPressed: () {
            Navigator.pop(context);
          },
          title: "Đóng",
          backgroundColor: FColors.transparent,
          color: FColors.blue6,
          block: true,
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
            });
          },
        ),
        FIconButton(
          icon: FOutlinedIcons.check_square,
          color: SkinColor.title,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          onPressed: () {
            setState(() {
              isSelectMode = !isSelectMode;
            });
          },
        ),
        FIconButton(
          icon: isGridViewMode ? FOutlinedIcons.paragraph : FOutlinedIcons.grid,
          color: SkinColor.title,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          onPressed: () {
            setState(() {
              isGridViewMode = !isGridViewMode;
            });
          },
        ),
        FIconButton(
          icon: FOutlinedIcons.sort_ascending,
          color: SkinColor.title,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          onPressed: () {
            showSortAction(context);
          },
        ),
      ],
      bodyTitle: FText("Recent", style: FTextStyle.largeTitle1),
    );
  }

  showChooseCompany(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: FColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
            margin: EdgeInsets.only(top: 32),
            child: FBottomSheet(
              header: FModal(
                title: FText(
                  "Lưu trữ file",
                  style: FTextStyle.titleModules3,
                ),
              ),
              body: Expanded(
                child: Container(
                  color: FColors.grey1,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        color: FColors.grey3,
                        child: FListTitle(
                          title: FText('Folder hiện tại',
                              style: FTextStyle.titleModules6),
                          subtitle:
                              FText('Recent', style: FTextStyle.subtitle2),
                          round: true,
                          avatar: FBoundingBox(
                            type: FBoundingBoxType.circle,
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
                      Expanded(
                        child: Consumer<CompanyProvider>(
                          builder: (context, comProvider, child) =>
                              ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: comProvider.getListCompany.length,
                            itemBuilder: (context, index) {
                              var company = comProvider.getListCompany[index];
                              return FListTitle(
                                title: FText(
                                  company.companyName,
                                  style: FTextStyle.titleModules6,
                                ),
                                avatar: FBoundingBox(
                                  type: FBoundingBoxType.circle,
                                  size: FBoxSize.size40x40,
                                  child: Image.memory(
                                    convert.base64Decode(
                                      company.avatarBase64.replaceFirst(
                                          "data:image/png;base64,", ""),
                                    ),
                                  ),
                                ),
                                action: [
                                  FRadioButton(
                                    toggle: true,
                                    groupValue: selectedCom,
                                    value: company,
                                    onChanged: (v) {
                                      setState(() {
                                        selectedCom = v;
                                      });
                                    },
                                  )
                                ],
                                // onTap: () {
                                //   setState(() {
                                //     if (selectedCom == null) {
                                //       selectedCom = company;
                                //     } else {
                                //       selectedCom = null;
                                //     }
                                //   });
                                // },
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: FButton(
                          size: FButtonSize.size40,
                          block: true,
                          title: "Move",
                          isLoading: isLoadingButton,
                          backgroundColor: FColors.green6,
                          onPressed: selectedCom != null
                              ? () async {
                                  if (isLoadingButton) return;
                                  setState(() {
                                    isLoadingButton = true;
                                  });
                                  try {
                                    var token =
                                        await storage.read(key: "token");
                                    var userName =
                                        await storage.read(key: "email");
                                    var uri = Uri.parse(
                                        "${Config.urlFile}mobile-upload-file");
                                    var multipartFiles =
                                        new List<http.MultipartFile>();
                                    var docs = fileProvider.getListRecent
                                        .where((el) => el.isSelected)
                                        .toList();
                                    for (var doc in docs) {
                                      var file = File(doc.docUri);
                                      var length = await file.length();
                                      multipartFiles.add(new http.MultipartFile(
                                        'file',
                                        file.openRead(),
                                        length,
                                        filename: doc.filename +
                                            path.extension(file.path),
                                      ));
                                    }

                                    var request =
                                        new http.MultipartRequest("POST", uri)
                                          ..headers.addAll({"token": token})
                                          ..files.addAll(multipartFiles);
                                    request.fields["comEmail"] =
                                        selectedCom.email;
                                    request.fields["username"] = userName;
                                    var response = await request.send();
                                    if (response.statusCode == 200) {
                                      try {
                                        if (Platform.isAndroid) {
                                          for (var doc in docs) {
                                            Directory(doc.docUri)
                                                .parent
                                                .deleteSync(recursive: true);
                                          }
                                        } else if (Platform.isIOS) {
                                          var imgFolder = [
                                            "originals",
                                            "documents",
                                            "unfilteredDocuments",
                                          ];
                                          for (var item
                                              in fileProvider.getListRecent) {
                                            var dir = item.previewOriDocUri;
                                            for (var folder in imgFolder) {
                                              Directory(dir.replaceAll(
                                                      "originals", folder))
                                                  .deleteSync(recursive: true);
                                              Directory(dir
                                                      .replaceAll(
                                                          "originals", folder)
                                                      .replaceAll(
                                                          "_preview", ""))
                                                  .deleteSync(recursive: true);
                                            }
                                          }
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                      var newRecentList = fileProvider
                                          .getListRecent
                                          .where((el) => !el.isSelected);
                                      fileProvider.setRecentDocs(
                                          newRecentList.toList());
                                      updateSelectMode(false);
                                      setState(() {
                                        isLoadingButton = false;
                                      });
                                      Navigator.pop(context);
                                      showFSnackBar(
                                          context,
                                          FSnackBar(
                                              position: FlushbarPosition.TOP,
                                              backgroundColor: FColors.green6,
                                              borderRadius: 8.0,
                                              icon: FIcon(
                                                icon: FFilledIcons.check_circle,
                                                color: [
                                                  FColors.grey1,
                                                  FColors.transparent,
                                                ],
                                                size: 24.0,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 8.0),
                                              message: FText(
                                                'Lưu file thành công',
                                                color: FColors.grey1,
                                              )));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              : null,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            // Column(
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
            //                 "Lưu trữ file",
            //                 style: FTextStyle.titleModules3,
            //               ),
            //             ),
            //           ),
            //           Container(width: 48),
            //         ],
            //       ),
            //     ),
            //     FDivider(),

            //   ],
            // ),
            ),
      ),
    );
  }

  updateSelectMode(bool value) {
    setState(() {
      isSelectMode = value;
    });
  }

  setSortType(type) {
    setState(() {
      sortType = type;
    });
  }

  showSortAction(BuildContext context) {
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
                  onTap: () {
                    setSortType(SortType.date_desc);
                    Navigator.pop(context);
                  },
                  action: sortType == SortType.date_desc
                      ? [
                          FIcon(
                            icon: FOutlinedIcons.check,
                            color: [FColors.blue6],
                            size: 16,
                          )
                        ]
                      : null,
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
                    setSortType(SortType.date_asc);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        )
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Container(
            //       height: 46,
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
            //                 "Sắp xếp",
            //                 style: FTextStyle.titleModules3,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 46,
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

  showDeleteConfirm(BuildContext context, FileProvider fileProvider) {
    var count = fileProvider.getListRecent.where((el) => el.isSelected).length;
    showFPopupActionSheet(
      context,
      FPopupActionSheet(
          backgroundColor: FColors.grey3,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          message: FText(
            "Những files này sẽ bị xóa khỏi kho dữ liệu chung, trên tất cả các thiết bị của bạn",
            textAlign: TextAlign.center,
          ),
          actions: [
            FPopupAction(
              title: "Xoá ${count.toString()} ${count == 1 ? "file" : "files"}",
              color: FColors.red6,
              onPressed: () async {
                try {
                  if (Platform.isAndroid) {
                    for (var item in fileProvider.getListRecent) {
                      if (item.isSelected) {
                        Directory(item.previewOriDocUri)
                            .parent
                            .deleteSync(recursive: true);
                      }
                    }
                    var newRecentList = fileProvider.getListRecent
                        .where((el) => !el.isSelected);
                    fileProvider.setRecentDocs(newRecentList.toList());
                  } else if (Platform.isIOS) {
                    var imgFolder = [
                      "originals",
                      "documents",
                      "unfilteredDocuments",
                    ];

                    for (var item in fileProvider.getListRecent) {
                      if (item.isSelected) {
                        var dir = item.previewOriDocUri;

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
                    }
                    var newRecentList = fileProvider.getListRecent
                        .where((el) => !el.isSelected);
                    fileProvider.setRecentDocs(newRecentList.toList());
                  }
                  setState(() {
                    isSelectMode = false;
                  });
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
            ),
            FPopupAction(
              title: 'Huỷ',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
    );
  }
}
