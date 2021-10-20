import 'dart:async';
import 'dart:io';
import 'package:Framework/FDA/Screens/SettingFileScreen.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/Document/Action/RecentDocs.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileItem.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class ListFile extends StatefulWidget {
  final SortType sortType;
  final bool isGridViewMode;
  final String comEmail;
  final String filename;
  ListFile({
    Key key,
    this.isGridViewMode = true,
    this.comEmail,
    this.sortType = SortType.date_desc,
    this.filename = "",
  }) : super(key: key);
  @override
  _ListDocsState createState() => _ListDocsState();
}

class _ListDocsState extends State<ListFile> {
  bool isLoadMore = false;
  bool isLoading = true;
  int pageSize = 16;
  Map<String, String> headers;
  ScrollController _controller = new ScrollController();
  static final storage = new FlutterSecureStorage();
  final DateFormat formatter = DateFormat('dd/MM/yyyy, HH:mm');

  @override
  void initState() {
    super.initState();
    getToken();
    getFileDAta();
    _controller.addListener(scrollToLoadMore);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(scrollToLoadMore);
  }

  @override
  void didUpdateWidget(ListFile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sortType != widget.sortType ||
        oldWidget.filename != widget.filename) {
      getFileDAta();
    }
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
                getFileDAta();
              },
              child: widget.isGridViewMode
                  ? gridView(fileProvider, appWidth)
                  : listView(fileProvider),
            ),
          );
  }

  scrollToLoadMore() async {
    if (isLoadMore) {
      return;
    }
    var pos = _controller.position;
    if (pos.extentAfter < 100) {
      setState(() {
        isLoadMore = true;
      });
      await loadMoreData();
      setState(() {
        isLoadMore = false;
      });
    }
  }

  getToken() async {
    var token = await storage.read(key: "token");
    headers = {"token": token};
  }

  String sortString(SortType sortType) {
    switch (sortType) {
      case SortType.alphabet_asc:
        return "filename:asc";
        break;
      case SortType.alphabet_desc:
        return "filename:desc";
        break;
      case SortType.date_asc:
        return "uploadDate:asc";
        break;
      default:
        return "uploadDate:desc";
        break;
    }
  }

  loadMoreData() async {
    var fileDA = new FileDA();
    var fileProvider = Provider.of<FileProvider>(context, listen: false);
    if (pageSize > fileProvider.getListDocs.length) {
      _controller.removeListener(scrollToLoadMore);
      return;
    }
    pageSize += 10;
    var result = await fileDA.getFiles("1", pageSize.toString(),
        widget.comEmail, widget.filename, sortString(widget.sortType));
    fileProvider.setListDocs(result.fileItems);
  }

  Future<String> getDemoStorageBaseDirectory() async {
    Directory storageDirectory;
    if (Platform.isAndroid) {
      storageDirectory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      storageDirectory = await getApplicationDocumentsDirectory();
    } else {
      throw ("Unsupported platform");
    }
    return "${storageDirectory.path}/my-files-storage";
  }

  getFileDAta() async {
    setState(() {
      isLoading = true;
    });
    var fileDA = new FileDA();
    var fileProvider = Provider.of<FileProvider>(context, listen: false);
    var result = await fileDA.getFiles("1", pageSize.toString(),
        widget.comEmail, widget.filename, sortString(widget.sortType));
    // List<FileItem> data = fileProvider.loadImage(result.fileItems);
    fileProvider.setListDocs(result.fileItems);
    setState(() {
      isLoading = false;
    });
  }

  // getPdfPreview(int index, String id) async {
  //   var baseDA = new BaseDA();
  //   var bytes = await baseDA.getFile(
  //       "http://service-invoice-fda-demo.paas.xplat.fpt.com.vn/file/$id");
  //   var pdfDocument = await PdfDocument.openData(bytes);
  //   var pdfPage = await pdfDocument.getPage(1);
  //   var pdfPageImage = await pdfPage.render(width: 366, height: 366);
  //   var imgBytes = pdfPageImage.bytes;
  //   Provider.of<DocumentProvider>(context, listen: false)
  //       .setPdfImage(index, imgBytes);
  // }

  gridView(FileProvider fileProvider, double appWidth) {
    return GridView.builder(
      controller: _controller,
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            (appWidth < 1000) ? appWidth * 0.5 : appWidth * (1 / 3),
        childAspectRatio: (appWidth < 1000)
            ? (appWidth * 0.5 - 48) / (appWidth * 0.5 + 48)
            : (appWidth * (1 / 3) - 64) / (appWidth * (1 / 3) + 48),
        crossAxisSpacing: 16,
        mainAxisSpacing: 0,
      ),
      itemCount: fileProvider.getListDocs.length,
      cacheExtent: 250,
      itemBuilder: (context, index) {
        var doc = fileProvider.getListDocs[index];
        return FCard(
          hasShadow: false,
          hasPadding: false,
          backgroundColor: FColors.transparent,
          alignment: CrossAxisAlignment.start,
          size: FBoxSize.auto_square,
          topItems: Container(
            padding: const EdgeInsets.all(8.0),
            child: FTag(
              title: doc.status['text'],
              color: doc.status['color'],
              backgroundColor: doc.status['backGround'],
              dottedBorder: false,
              leftIcon: doc.status['icon'],
            ),
          ),
          avatar: Hero(
            tag: doc.documentId,
            child: doc.filename.endsWith(".png") ||
                    doc.filename.endsWith(".jpg") ||
                    doc.filename.endsWith(".jpeg")
                ? Image.network(
                    '${Config.urlFile}file/${doc.documentId}',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    headers: headers,
                    filterQuality: FilterQuality.none,
                    loadingBuilder: (context, child, progress) =>
                        progress == null
                            ? child
                            : Container(
                                color: FColors.grey4,
                              ),
                  )
                : Image.asset(
                    'lib/FIS.SYS/Assets/images/ImgDocs.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
          ),
          title: FText(
            doc.filename,
            style: FTextStyle.bodyText2,
            color: SkinColor.title,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: FText(
            doc.uploadUser + "\n" + formatter.format(doc.uploadDate),
            style: FTextStyle.subtitle2,
            color: SkinColor.subTitle,
          ),
          // actionChildren: [
          //   FIconButton(
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     icon: FOutlinedIcons.ellipsis,
          //     color: SkinColor.title,
          //     backgroundColor: SkinColor.backGroundSearch,
          //     size: FIconButtonSize.size24,
          //     onPressed: () {
          //       // showAction(context, doc);
          //     },
          //   ),
          // ],
          onTap: () {
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (context) => DocumentDetailScreen(
            //       heroTag: doc.fileId,
            //       image: doc.thumbnailInvoice,
            //     ),
            //   ),
            // );

            try {
              // if (doc.filename.endsWith(".pdf"))
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SettingFileScreen(
              //         filename: doc.filename,
              //         fileLink: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
              //         disable: true,
              //         // .replaceAll("file://", "")
              //         //.replaceAll("_preview", ""),
              //       ),
              //     ),
              //   );
              // else
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SettingFileScreen(
              //         filename: doc.filename,
              //         fileLink: '${Config.urlFile}file/${doc.documentId}',
              //         disable: true,
              //         // .replaceAll("file://", "")
              //         //.replaceAll("_preview", ""),
              //       ),
              //     ),
              //   );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingFileScreen(
                    filename: doc.filename,
                    fileLink: '${Config.urlFile}file/${doc.documentId}',
                    disable: true,

                    // .replaceAll("file://", "")
                    //.replaceAll("_preview", ""),
                  ),
                ),
              );
            } catch (e) {}
          },
        );
      },
    );
  }

  listView(FileProvider fileProvider) {
    return ListView.builder(
      controller: _controller,
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: fileProvider.getListDocs.length,
      cacheExtent: 250,
      itemBuilder: (context, index) {
        var doc = fileProvider.getListDocs[index];
        return FListTitle(
          height: 72,
          avatar: FBoundingBox(
            size: FBoxSize.size48x48,
            topItems: Container(
              padding: EdgeInsets.only(top: 4, right: 4),
              child: FBoundingBox(
                size: FBoxSize.size16x16,
                type: FBoundingBoxType.circle,
                backgroundColor: doc.status['color'],
                child: FIcon(
                  icon: doc.status['icon'],
                  size: 10.0,
                  color: [FColors.grey1, doc.status['color']],
                ),
              ),
            ),
            child: Hero(
              tag: doc.documentId,
              child: doc.filename.endsWith(".pdf")
                  ? Image.asset(
                      'lib/FIS.SYS/Assets/images/ImgDocs.png',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    )
                  : Image.network(
                      '${Config.urlFile}file/${doc.documentId}',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      headers: headers,
                    ),
            ),
          ),
          title: FText(
            doc.filename,
            style: FTextStyle.bodyText2,
            color: SkinColor.title,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: FText(
            "${doc.uploadUser}, ${formatter.format(doc.uploadDate)}",
            style: FTextStyle.subtitle2,
            color: SkinColor.subTitle,
            maxLines: 1,
          ),
          // action: [
          //   FIconButton(
          //     size: FIconButtonSize.size32,
          //     icon: FOutlinedIcons.ellipsis,
          //     backgroundColor: FColors.transparent,
          //     color: FColors.grey10,
          //     onPressed: () {
          //       // showAction(context, doc);
          //     },
          //   )
          // ],
          onTap: () {
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (context) => DocumentDetailScreen(
            //       heroTag: doc.fileId,
            //       image: doc.thumbnailInvoice,
            //     ),
            //   ),
            // );
            try {
              // if (doc.filename.endsWith(".png") ||
              //     doc.filename.endsWith(".jpg") ||
              //     doc.filename.endsWith(".jpeg") ||
              //     doc.filename.endsWith(".gif"))
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SettingFileScreen(
              //       filename: doc.filename,
              //         fileLink: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
              // disable: true,

              //       // .replaceAll("file://", "")
              //       //.replaceAll("_preview", ""),
              //     ),
              //   ),
              // );
              // else
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SettingFileScreen(
              //         filename: doc.filename,
              //       fileLink: '${Config.urlFile}file/${doc.documentId}',
              // disable: true,

              //         // .replaceAll("file://", "")
              //         //.replaceAll("_preview", ""),
              //       ),
              //     ),
              //   );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingFileScreen(
                    filename: doc.filename,
                    fileLink: '${Config.urlFile}file/${doc.documentId}',
                    disable: true,

                    // .replaceAll("file://", "")
                    //.replaceAll("_preview", ""),
                  ),
                ),
              );
            } catch (e) {}
          },
        );
      },
    );
  }
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
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: FColors.grey1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  FIconButton(
                    color: FColors.grey10,
                    icon: FOutlinedIcons.close,
                    backgroundColor: FColors.transparent,
                    buttonStyle: FIconButtonStyle.iconAction,
                    size: FIconButtonSize.size48,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: FText(
                        "Tác vụ",
                        style: FTextStyle.titleModules3,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FListTitle(
                    title: FText("Chia sẻ"),
                    height: 48,
                    avatar: FBoundingBox(
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      backgroundColor: FColors.green1,
                      child: FIcon(
                        icon: FOutlinedIcons.share_alt,
                        color: [FColors.green6],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// final width = MediaQuery.of(context).size.width;
// Map<String, dynamic> name = ModalRoute.of(context).settings.arguments;

// Map<String, String> headers = {
//   "token": Provider.of<UserProvider>(context, listen: true).getUser.token,
// };
// bool isParagraph =
//     Provider.of<DocumentProvider>(context, listen: false).getParagraph;

// return NotificationListener(
//   onNotification: _onNotification,
//   child: SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         isLoading
//             ? CircularProgressIndicator()
//             : Consumer<FilesProvider>(
//                 builder: (context, documentProvider, child) => FRow(
//                   children: [
//                     // FColumn(
//                     //   columnType: FColumnType.col_100,
//                     //   child: documentProvider.files.length == 0
//                     //       ? Column(
//                     //           mainAxisAlignment: MainAxisAlignment.center,
//                     //           children: [
//                     //             SizedBox(
//                     //               height: 100,
//                     //             ),
//                     //             Center(
//                     //               child: Text('Không có gì để hiện thị'),
//                     //             ),
//                     //           ],
//                     //         )
//                     //       : Container(),
//                     // ),
//                     // for (var doc in documentProvider.files)
//                     FColumn(
//                       columnType: FColumnType.col_100,
//                       child: documentProvider.files.length == 0
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   height: 100,
//                                 ),
//                                 Center(
//                                   child: Text('Không có gì để hiện thị'),
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                     ),
//                     for (var doc in documentProvider.files)
//                       !isParagraph
//                           ? FColumn(
//                               columnType: FColumnType.col_100,
//                               child: Container(
//                                 margin: EdgeInsets.only(bottom: 1),
//                                 child: FListTitle(
//                                   avatar: FBoundingBox(
//                                     backgroundColor:
//                                         SkinColor.backTransparent,
//                                     size: FBoxSize.size48x48,
//                                     child: GestureDetector(
//                                       onTap: () {},
//                                       child: checkImage(doc.filename)
//                                           ? Image.network(
//                                               'http://service-invoice-fda-demo.paas.xplat.fpt.com.vn/file/${doc.id}',
//                                               fit: BoxFit.cover,
//                                               height: 183,
//                                               width: 183,
//                                               headers: headers,
//                                             )
//                                           : checkPdf(doc.filename) &&
//                                                   doc.image != null
//                                               ? Image(
//                                                   image: MemoryImage(
//                                                       doc.image),
//                                                   fit: BoxFit.cover,
//                                                   height: 183,
//                                                   width: 183,
//                                                 )
//                                               : Image.asset(
//                                                   'lib/FIS.SYS/Assets/images/ImgDocs.png',
//                                                   fit: BoxFit.cover,
//                                                   height: 183,
//                                                   width: 183,
//                                                 ),
//                                     ),
//                                     topItems: Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: FBoundingBox(
//                                         size: FBoxSize.size16x16,
//                                         type: FBoundingBoxType.circle,
//                                         backgroundColor:
//                                             statusCode[doc.status]['color'],
//                                         // child: FTag(
//                                         //   title: '',
//                                         //   color: FColors.grey1,
//                                         // backgroundColor: statusCode[doc.status]
//                                         //       ['color'],
//                                         //   dottedBorder: false,
//                                         // leftIcon: statusCode[doc.status]
//                                         //     ['icon'],
//                                         //   size: FTagSize.small,
//                                         // ),
//                                         child: FIcon(
//                                           icon: statusCode[doc.status]
//                                               ['icon'],
//                                           color: [FColors.grey1],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   title: FText(
//                                     doc.filename,
//                                     style: FTextStyle.bodyText2,
//                                     color: SkinColor.title,
//                                     softWrap: true,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   subtitle: FText(
//                                     '${doc.uploadUser}, ${readTimestamp(doc.uploadDate)}',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: FTextStyle.subtitle2,
//                                     color: SkinColor.subTitle,
//                                   ),
//                                   action: [
//                                     FIconButton(
//                                       icon: FOutlinedIcons.ellipsis,
//                                       color: FColors.grey6,
//                                       tapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       buttonStyle: FIconButtonStyle.solid,
//                                       backgroundColor: FColors.transparent,
//                                       size: FIconButtonSize.size24,
//                                       onPressed: () {},
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : FColumn(
//                               columnType: (width <= 1000)
//                                   ? FColumnType.col_50
//                                   : FColumnType.col_25,
//                               child: Container(
//                                 margin:
//                                     EdgeInsets.only(bottom: 10, top: 24),
//                                 child: FCard(
//                                   hasShadow: false,
//                                   backgroundColor:
//                                       SkinColor.backTransparent,
//                                   alignment: CrossAxisAlignment.start,
//                                   hasPadding: false,
//                                   size: FBoxSize.auto_square,
//                                   topItems: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: FTag(
//                                       title: statusCode[doc.status]['text'],
//                                       color: statusCode[doc.status]
//                                           ['color'],
//                                       backgroundColor:
//                                           statusCode[doc.status]
//                                               ['backGround'],
//                                       dottedBorder: false,
//                                       leftIcon: statusCode[doc.status]
//                                           ['icon'],
//                                     ),
//                                   ),
//                                   avatar: GestureDetector(
//                                     onTap: () {},
//                                     child: checkImage(doc.filename)
//                                         ? Image.network(
//                                             'http://service-invoice-fda-demo.paas.xplat.fpt.com.vn/file/${doc.id}',
//                                             fit: BoxFit.cover,
//                                             height: 183,
//                                             width: 183,
//                                             headers: headers,
//                                           )
//                                         : checkPdf(doc.filename) &&
//                                                 doc.image != null
//                                             ? Image(
//                                                 image:
//                                                     MemoryImage(doc.image),
//                                                 fit: BoxFit.cover,
//                                                 height: 183,
//                                                 width: 183,
//                                               )
//                                             : Image.asset(
//                                                 'lib/FIS.SYS/Assets/images/ImgDocs.png',
//                                                 fit: BoxFit.cover,
//                                                 height: 183,
//                                                 width: 183,
//                                               ),
//                                   ),
//                                   title: FText(
//                                     doc.filename,
//                                     style: FTextStyle.bodyText2,
//                                     color: SkinColor.title,
//                                     softWrap: true,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   subtitle: FText(
//                                     doc.uploadUser,
//                                     style: FTextStyle.subtitle2,
//                                     color: SkinColor.subTitle,
//                                   ),
//                                   content: FText(
//                                     readTimestamp(doc.uploadDate),
//                                     style: FTextStyle.subtitle2,
//                                     color: SkinColor.subTitle,
//                                   ),
//                                   // actionChildren: [
//                                   //   FIconButton(
//                                   //     icon: FOutlinedIcons.ellipsis,
//                                   //     color: SkinColor.title,
//                                   //     backgroundColor: SkinColor.backGroundSearch,
//                                   //     size: FIconButtonSize.size24,
//                                   //     onPressed: () {
//                                   //       more(context);
//                                   //     },
//                                   //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                   //   ),
//                                   // ],
//                                 ),
//                               ),
//                             )
//                   ],
//                 ),
//               ),
//       ],
//     ),
//   ),
// );
