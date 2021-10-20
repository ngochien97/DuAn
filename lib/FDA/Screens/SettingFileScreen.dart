import 'dart:io';
import 'dart:typed_data';
import 'package:Framework/F.Utils/Convert.dart';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/PopupActionSheetBar.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Components/ToolBar.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyItem.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class TypeOfKeepBusinessAccounts {
  String type;
  String invoiceSubType;

  TypeOfKeepBusinessAccounts({
    this.type,
    this.invoiceSubType,
  });
}

class SettingFileScreen extends StatefulWidget {
  final String fileUri;
  final String fileLink;
  final String filename;
  final bool disable;

  SettingFileScreen({
    Key key,
    this.fileUri,
    this.filename,
    this.fileLink,
    this.disable = false,
  }) : super(key: key);

  @override
  _SettingFileScreenState createState() => _SettingFileScreenState();
}

class _SettingFileScreenState extends State<SettingFileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final storage = new FlutterSecureStorage();
  var nameController = new TextEditingController();
  String filNameHolder = 'Untitled Photo';
  String fileName = 'Untitled Photo';
  CompanyItem selectedComHolder;
  CompanyItem selectedCom;
  bool isLoading = false;

  Uint8List byte;
  List<PdfPageImage> pages = [];

  List<TypeOfKeepBusinessAccounts> data = [
    TypeOfKeepBusinessAccounts(type: "Chứng từ kế toán", invoiceSubType: "0"),
    TypeOfKeepBusinessAccounts(type: "Kho", invoiceSubType: "1"),
  ];
  TypeOfKeepBusinessAccounts invoiceSubTypeGroup;
  TypeOfKeepBusinessAccounts invoiceSubType;

  @override
  void initState() {
    super.initState();

    var currentCom =
        Provider.of<CompanyProvider>(context, listen: false).currentCom;
    if (currentCom != null) {
      setState(() {
        selectedCom = currentCom;
        selectedComHolder = currentCom;
      });
    }

    if (widget.filename != null && widget.filename.endsWith(".pdf")) {
      pdfToImage(widget.fileLink);
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      fileName = widget.filename != null ? widget.filename : fileName;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: FColors.grey3,
      appBar: FAppBar(
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText('Cài đặt file', style: FTextStyle.titleModules3),
        ),
        headerLead: FIconButton(
          icon: FOutlinedIcons.left,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          onPressed: () {
            Navigator.pop(context);
          },
          color: FColors.grey9,
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  FText('Uploading...'),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: FListTitle(
                      title: FText('Tên File', style: FTextStyle.titleModules6),
                      subtitle: FText(fileName, style: FTextStyle.subtitle2),
                      round: true,
                      avatar: FBoundingBox(
                        type: FBoundingBoxType.circle,
                        backgroundColor: FColors.green2,
                        size: FBoxSize.size32x32,
                        child: FIcon(
                          color: [FColors.green6, FColors.transparent],
                          size: 20,
                          icon: FFilledIcons.document,
                        ),
                      ),
                      action: [
                        !widget.disable
                            ? FButton(
                                title: 'Sửa',
                                backgroundColor: FColors.transparent,
                                color: FColors.grey7,
                                rightIcon: FOutlinedIcons.edit,
                                size: FButtonSize.size40,
                                block: true,
                                onPressed: () {
                                  showActionChangeName(context);
                                },
                              )
                            : Container(),
                      ],
                      onTap: () {
                        !widget.disable ? showActionChangeName(context) : () {};
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: FListTitle(
                      title: FText('Lưu vào folder',
                          style: FTextStyle.titleModules6),
                      subtitle: FText(
                        selectedCom == null
                            ? 'Recent'
                            : selectedCom.companyName,
                        style: FTextStyle.subtitle2,
                      ),
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
                      action: [
                        !widget.disable
                            ? FButton(
                                title: 'Sửa',
                                backgroundColor: FColors.transparent,
                                color: FColors.grey7,
                                rightIcon: FOutlinedIcons.edit,
                                size: FButtonSize.size40,
                                block: true,
                                onPressed: () {
                                  showActionSelectCompany(context);
                                },
                              )
                            : Container(),
                      ],
                      onTap: () {
                        !widget.disable
                            ? showActionSelectCompany(context)
                            : () {};
                      },
                    ),
                  ),
                  !widget.disable
                      ? Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: FListTitle(
                            title: FText('Loại hạch toán',
                                style: FTextStyle.titleModules6),
                            subtitle: FText(
                              invoiceSubType == null
                                  ? 'Chứng từ kế toán'
                                  : invoiceSubType.type,
                              style: FTextStyle.subtitle2,
                            ),
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
                            action: [
                              !widget.disable
                                  ? FButton(
                                      title: 'Sửa',
                                      backgroundColor: FColors.transparent,
                                      color: FColors.grey7,
                                      rightIcon: FOutlinedIcons.edit,
                                      size: FButtonSize.size40,
                                      block: true,
                                      onPressed: () {
                                        showActionSelectTypeOfKeepBusinessAccounts(
                                            context);
                                      },
                                    )
                                  : Container(),
                            ],
                            onTap: () {},
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: widget.fileUri != null
                        ? Image.file(File(widget.fileUri), fit: BoxFit.contain)
                        : widget.filename.endsWith(".pdf")
                            ? pages.length > 0
                                ? ListView.builder(
                                    itemCount: pages.length,
                                    itemBuilder: (context, index) {
                                      var page = pages[index];
                                      return Image.memory(
                                        page.bytes,
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          FText('Loading...'),
                                        ],
                                      ),
                                    ),
                                  )
                            : Image.network(widget.fileLink,
                                fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: FToolBar(
        children: [
          FToolBarItem(
            title: 'Xóa',
            color: FColors.blue6,
            onTap: !widget.disable
                ? () {
                    showDeleteConfirm(context, widget.fileUri);
                  }
                : null,
          ),
          FToolBarItem(
            title: 'Share',
            color: FColors.blue6,
            onTap: !widget.disable
                ? () {
                    Share.shareFiles([widget.fileUri]);
                  }
                : null,
          ),
          FToolBarItem(
            title: 'Lưu',
            color: FColors.blue6,
            onTap: !widget.disable
                ? selectedCom == null
                    ? () {
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            backgroundColor: SkinColor.IconDelete,
                            duration: Duration(milliseconds: 3000),
                            content: Row(
                              children: [
                                FBoundingBox(
                                  child: FIcon(
                                    icon: FFilledIcons.close_circle,
                                    color: [SkinColor.backGround],
                                    size: 24,
                                  ),
                                  type: FBoundingBoxType.circle,
                                  backgroundColor: FColors.transparent,
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                          'Hãy chọn folder lưu trữ để tiếp tục!')),
                                ),
                              ],
                            ),
                          ),
                        );
                        // showFSnackBar(
                        //   context,
                        //   FSnackBar(
                        //     backgroundColor: SkinColor.IconDelete,
                        //     icon: FIcon(
                        //       icon: FFilledIcons.close_circle,
                        //       color: [
                        //         SkinColor.backGround,
                        //       ],
                        //       size: 24,
                        //     ),
                        //     borderRadius: 8.0,
                        //     message: FText(
                        //       'Hãy chọn folder lưu trữ để tiếp tục!',
                        //       color: SkinColor.backGround,
                        //     ),
                        //     animationDuration: Duration(milliseconds: 500),
                        //     duration: Duration(milliseconds: 3000),
                        //     margin: EdgeInsets.only(
                        //         left: 16.0, right: 16.0, bottom: 20.0),
                        //   ),
                        // );
                      }
                    : () async {
                        if (isLoading) return;
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          var fileDA = new FileDA();
                          var userName = await storage.read(key: "email");
                          var fields = {
                            "comEmail": selectedCom.email,
                            "username": userName,
                            "invoiceSubtype": invoiceSubType == null
                                ? 0
                                : invoiceSubType.invoiceSubType,
                          };
                          var response = await fileDA.postFile(
                            File(widget.fileUri),
                            fields,
                            fileName,
                          );

                          if (response.statusCode == 200) {
                            try {
                              if (Platform.isAndroid) {
                                Directory(widget.fileUri)
                                    .parent
                                    .deleteSync(recursive: true);
                              } else if (Platform.isIOS) {
                                var imgFolder = [
                                  "originals",
                                  "documents",
                                  "unfilteredDocuments",
                                ];
                                var dir = Directory(widget.fileUri).path;
                                for (var folder in imgFolder) {
                                  Directory(dir.replaceAll("documents", folder))
                                      .deleteSync(recursive: true);
                                  Directory(dir
                                          .replaceAll("documents", folder)
                                          .replaceAll(".jpg", "_preview.jpg"))
                                      .deleteSync(recursive: true);
                                }
                              }
                            } catch (e) {
                              print(e);
                            }

                            var fileProvider = Provider.of<FileProvider>(
                                context,
                                listen: false);
                            if (fileProvider.getListRecent
                                    .where((el) => el.docUri == widget.fileUri)
                                    .length >
                                0) {
                              fileProvider.setRecentDocs(fileProvider
                                  .getListRecent
                                  .where((el) => el.docUri != widget.fileUri)
                                  .toList());
                            }

                            Navigator.pop(context);
                            showFSnackBar(
                              context,
                              FSnackBar(
                                position: FlushbarPosition.TOP,
                                backgroundColor: FColors.green6,
                                icon: FIcon(
                                  icon: FFilledIcons.check_circle,
                                  color: [FColors.grey1, FColors.transparent],
                                  size: 24,
                                ),
                                borderRadius: 8.0,
                                message: FText(
                                  'Lưu file thành công',
                                  color: FColors.grey1,
                                ),
                                animationDuration: Duration(milliseconds: 500),
                                duration: Duration(milliseconds: 3000),
                                margin: EdgeInsets.only(
                                    left: 16.0, right: 16.0, bottom: 70.0),
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                : null,
          ),
        ],
      ),
    );
  }

  showActionSelectCompany(BuildContext context) {
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
            mainAxisSize: MainAxisSize.max,
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
                        subtitle: FText(
                          selectedCom == null
                              ? 'Recent'
                              : selectedCom.companyName,
                          style: FTextStyle.subtitle2,
                        ),
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
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  toggle: true,
                                  groupValue: selectedComHolder,
                                  value: company,
                                  onChanged: (v) {
                                    setState(() {
                                      selectedComHolder = company;
                                      selectedCom = company;
                                    });
                                  },
                                )
                              ],
                              onTap: () {
                                setState(() {
                                  if (selectedComHolder == company) {
                                    selectedComHolder = company;
                                    selectedCom = company;
                                  } else {
                                    selectedComHolder = company;
                                    selectedCom = company;
                                  }
                                });
                              },
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
                        backgroundColor: FColors.green6,
                        onPressed: selectedComHolder != null
                            ? () {
                                setCom();
                                Navigator.pop(context);
                              }
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showActionSelectTypeOfKeepBusinessAccounts(BuildContext context) {
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
            mainAxisSize: MainAxisSize.max,
            header: FModal(
              title: FText(
                "Loại hạch toán",
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
                        title: FText('Loại hạch toán hiện tại',
                            style: FTextStyle.titleModules6),
                        subtitle: FText(
                          invoiceSubType == null
                              ? 'Chứng từ kế toán'
                              : invoiceSubType.type,
                          style: FTextStyle.subtitle2,
                        ),
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
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var invoiceSubType = data[index];
                          return FListTitle(
                            title: FText(
                              data[index].type,
                              style: FTextStyle.titleModules6,
                            ),
                            action: [
                              FRadioButton(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                toggle: true,
                                groupValue: invoiceSubTypeGroup,
                                value: invoiceSubType,
                                onChanged: (v) {
                                  setState(() {
                                    invoiceSubTypeGroup = invoiceSubType;
                                    invoiceSubType = invoiceSubType;
                                  });
                                },
                              )
                            ],
                            onTap: () {
                              setState(() {
                                if (invoiceSubTypeGroup == invoiceSubType) {
                                  invoiceSubTypeGroup = invoiceSubType;
                                  invoiceSubType = invoiceSubType;
                                } else {
                                  invoiceSubTypeGroup = invoiceSubType;
                                  invoiceSubType = invoiceSubType;
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: FButton(
                        size: FButtonSize.size40,
                        block: true,
                        title: "OK",
                        backgroundColor: FColors.green6,
                        onPressed: invoiceSubTypeGroup != null
                            ? () {
                                setType();
                                Navigator.pop(context);
                              }
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  setCom() {
    setState(() {
      selectedCom = selectedComHolder;
    });
  }

  setType() {
    setState(() {
      invoiceSubType = invoiceSubTypeGroup;
    });
  }

  showActionChangeName(BuildContext context) {
    nameController.text = filNameHolder;
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
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 32),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: FBottomSheet(
              header: FModal(
                title: FText(
                  "Sửa tên file",
                  style: FTextStyle.titleModules3,
                ),
                textAction: Container(
                  width: 48,
                  child: FButton(
                    color: FColors.grey10,
                    backgroundColor: FColors.transparent,
                    title: "Lưu",
                    onPressed: () {
                      setState(() {
                        fileName = filNameHolder;
                      });
                      Navigator.pop(context);
                    },
                    block: true,
                  ),
                ),
              ),
              body: Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: FColors.grey1,
                  child: FTextField(
                    controller: nameController,
                    label: "Tên file",
                    autoFocus: true,
                    size: FTextFieldSize.size56,
                    value: filNameHolder,
                    onChanged: (value) {
                      setState(() {
                        filNameHolder = value;
                      });
                    },
                  ),
                ),
              ),
            )
            // Container(
            //   color: Colors.transparent,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 56,
            //         decoration: BoxDecoration(
            //           color: FColors.grey1,
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(12),
            //             topRight: Radius.circular(12),
            //           ),
            //         ),
            //         child: Row(
            //           children: [
            //             FIconButton(
            //               color: FColors.grey10,
            //               icon: FOutlinedIcons.close,
            //               backgroundColor: FColors.transparent,
            //               buttonStyle: FIconButtonStyle.iconAction,
            //               size: FIconButtonSize.size48,
            //               onPressed: () {
            //                 Navigator.pop(context);
            //               },
            //             ),
            //             Expanded(
            //               child: Container(
            //                 alignment: Alignment.center,
            //                 child: FText(
            //                   "Sửa tên file",
            //                   style: FTextStyle.titleModules3,
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               width: 48,
            //               child: FButton(
            //                 color: FColors.grey10,
            //                 backgroundColor: FColors.transparent,
            //                 title: "Lưu",
            //                 onPressed: () {
            //                   setState(() {
            //                     fileName = filNameHolder;
            //                   });
            //                   Navigator.pop(context);
            //                 },
            //                 block: true,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       FDivider(),
            //       Container(
            //         padding: EdgeInsets.all(16),
            //         child: FTextField(
            //           label: "Tên file",
            //           autoFocus: true,
            //           size: FTextFieldSize.size56,
            //           value: filNameHolder,
            //           onChanged: (value) {
            //             setState(() {
            //               filNameHolder = value;
            //             });
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }

  pdfToImage(String id) async {
    FileDA fileDA = new FileDA();
    var bytes = await fileDA.getFile(id);
    final document = await PdfDocument.openData(bytes);
    print(document.pagesCount);
    // final page = await document.getPage(1);
    // final pageImage = await page.render(width: page.width, height: page.height);
    // await page.close();
    for (var p = 1; p <= document.pagesCount; p++) {
      var page = await document.getPage(p);
      final pageImage =
          await page.render(width: page.width, height: page.height);
      await page.close();
      setState(() {
        pages.add(pageImage);
      });
    }
    // setState(() {
    //   byte = pageImage.bytes;
    // });
  }

  // Future<Uint8List> imageToPdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: ,
  //       build: (context) {
  //         return pw.Center(
  //           child: pw.Text(title),
  //         );
  //       },
  //     ),
  //   );
  //   return pdf.save();
  // }

  showDeleteConfirm(BuildContext context, String docUri) {
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
              title: "Xoá",
              color: FColors.red6,
              onPressed: () async {
                try {
                  if (Platform.isAndroid) {
                    Directory(docUri).parent.deleteSync(recursive: true);
                  } else if (Platform.isIOS) {
                    var imgFolder = [
                      "originals",
                      "documents",
                      "unfilteredDocuments",
                    ];
                    var dir = docUri;
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

                  var fileProvider =
                      Provider.of<FileProvider>(context, listen: false);
                  fileProvider.setRecentDocs(fileProvider.getListRecent
                      .where((el) => el.docUri != widget.fileUri)
                      .toList());
                  var count = 0;
                  Navigator.popUntil(context, (_) {
                    return count++ == 2;
                  });
                } catch (e) {
                  print(e);
                }
              },
            ),
            FPopupAction(
              title: "Huỷ",
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
    );
    // showModalBottomSheet(
    //   backgroundColor: FColors.transparent,
    //   context: context,
    //   builder: (context) => Container(
    //     margin: EdgeInsets.all(16),
    //     decoration: BoxDecoration(
    //       color: FColors.grey3,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     padding: EdgeInsets.all(16),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         FText(
    //           "Những files này sẽ bị xóa khỏi kho dữ liệu chung, trên tất cả các thiết bị của bạn",
    //           textAlign: TextAlign.center,
    //         ),
    //         FSpacer.space8px,
    //         FListTitle(
    //           title: FText(
    //             "Xoá",
    //             style: FTextStyle.titleModules3,
    //             color: FColors.red6,
    //             textAlign: TextAlign.center,
    //           ),
    //           onTap:
    //         ),
    //         FSpacer.space8px,
    //         FListTitle(
    //           onTap: () {
    //             Navigator.pop(context);
    //           },
    //           title: FText(
    //             "Huỷ",
    //             style: FTextStyle.titleModules3,
    //             color: FColors.blue6,
    //             textAlign: TextAlign.center,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
