// import 'dart:async';
// import 'package:Framework/FIS.SYS/Skins/Icon.dart';
// import 'package:Framework/FDA/Providers/DocumentProvider.dart';
// import 'package:Framework/FDA/Screens/DocumentDetail.dart';
// import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
// import 'package:Framework/FIS.SYS/Modules/Document/DocumentDA.dart';
// import 'package:Framework/FIS.SYS/Modules/Document/DocumentItem.dart';
// import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
// import 'package:Framework/FIS.SYS/Skins/Typography.dart';
// import 'package:Framework/FIS.SYS/Styles/Icons.dart';
// import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert' as convert;

// class ListDocs extends StatefulWidget {
//   final bool isGridViewMode;
//   final String comEmail;

//   ListDocs({
//     Key key,
//     this.isGridViewMode = true,
//     this.comEmail,
//   }) : super(key: key);
//   @override
//   _ListDocsState createState() => _ListDocsState();
// }

// class _ListDocsState extends State<ListDocs> {
//   bool isLoading = true;
//   int pageSize = 10;

//   ScrollController _controller = new ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     getDocumentData();

//     _controller.addListener(() async {
//       var pos = _controller.position;
//       if ((pos.maxScrollExtent - pos.pixels).round() < 250) {
//         await loadMoreData();
//       }
//     });
//   }

//   loadMoreData() async {
//     var docDA = new DocumentDA();
//     var fileProvider = Provider.of<DocumentProvider>(context, listen: false);
//     if (pageSize > fileProvider.getListDocs.length) {
//       return;
//     }
//     pageSize += 10;
//     var result = await docDA.getDocumentData(
//         "1", pageSize.toString(), widget.comEmail, "filename:desc");
//     fileProvider.setListDocs(result.listDocumentItem);
//   }

//   getDocumentData() async {
//     setState(() {
//       isLoading = true;
//     });
//     Timer(Duration(seconds: 0), () async {
//       var docDA = new DocumentDA();
//       var fileProvider = Provider.of<DocumentProvider>(context, listen: false);
//       var result = await docDA.getDocumentData(
//           "1", pageSize.toString(), widget.comEmail, "filename:desc");
//       fileProvider.setListDocs(result.listDocumentItem);
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appWidth = MediaQuery.of(context).size.width;

//     return isLoading
//         ? Container(
//             height: 100,
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ),
//           )
//         : Consumer<DocumentProvider>(
//             builder: (context, fileProvider, _) => RefreshIndicator(
//               onRefresh: () async {
//                 getDocumentData();
//               },
//               child: widget.isGridViewMode
//                   ? gridView(fileProvider, appWidth)
//                   : listView(fileProvider),
//             ),
//           );
//   }

//   gridView(DocumentProvider fileProvider, double appWidth) {
//     return GridView.builder(
//       controller: _controller,
//       physics: BouncingScrollPhysics(),
//       padding: EdgeInsets.all(16),
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent:
//             (appWidth < 1000) ? appWidth * 0.5 : appWidth * (1 / 3),
//         childAspectRatio: (appWidth < 1000)
//             ? (appWidth * 0.5 - 48) / (appWidth * 0.5 + 48)
//             : (appWidth * (1 / 3) - 64) / (appWidth * (1 / 3) + 48),
//         crossAxisSpacing: 16,
//       ),
//       itemCount: fileProvider.getListDocs.length,
//       itemBuilder: (context, index) {
//         var doc = fileProvider.getListDocs[index];
//         return FCard(
//           hasShadow: false,
//           hasPadding: false,
//           backgroundColor: FColors.transparent,
//           alignment: CrossAxisAlignment.start,
//           size: FBoxSize.auto_square,
//           topItems: Container(
//             padding: const EdgeInsets.all(8.0),
//             child: FTag(
//               title: doc.status['text'],
//               color: doc.status['color'],
//               backgroundColor: doc.status['backGround'],
//               dottedBorder: false,
//               leftIcon: doc.status['icon'],
//             ),
//           ),
//           avatar: Hero(
//             tag: doc.fileId,
//             child: Image.memory(
//               convert.base64Decode(
//                 doc.thumbnailInvoice
//                     .replaceFirst("data:image/jpeg;base64,", ""),
//               ),
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           title: FText(
//             doc.filename,
//             style: FTextStyle.bodyText2,
//             color: SkinColor.title,
//             softWrap: true,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           subtitle: FText(
//             doc.uploadUser + "\n" + doc.createdDate.toString().substring(0, 19),
//             style: FTextStyle.subtitle2,
//             color: SkinColor.subTitle,
//           ),
//           actionChildren: [
//             FIconButton(
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               icon: FOutlinedIcons.ellipsis,
//               color: SkinColor.title,
//               backgroundColor: SkinColor.backGroundSearch,
//               size: FIconButtonSize.size24,
//               onPressed: () {
//                 // showAction(context, doc);
//               },
//             ),
//           ],
//           onTap: () {
//             SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//             Navigator.push(
//               context,
//               MaterialPageRoute<void>(
//                 builder: (context) => DocumentDetailScreen(
//                   heroTag: doc.fileId,
//                   image: doc.thumbnailInvoice,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   listView(DocumentProvider fileProvider) {
//     return ListView.builder(
//       controller: _controller,
//       physics: BouncingScrollPhysics(),
//       itemCount: fileProvider.getListDocs.length,
//       itemBuilder: (context, index) {
//         var doc = fileProvider.getListDocs[index];
//         return FListTitle(
//           height: 72,
//           avatar: FBoundingBox(
//             size: FBoxSize.size48x48,
//             child: Stack(
//               children: [
//                 Hero(
//                   tag: doc.fileId,
//                   child: Image.memory(
//                     convert.base64Decode(
//                       doc.thumbnailInvoice
//                           .replaceFirst("data:image/jpeg;base64,", ""),
//                     ),
//                     fit: BoxFit.cover,
//                     height: double.infinity,
//                     width: double.infinity,
//                   ),
//                 ),
//                 Positioned(
//                     left: 28.0,
//                     top: 4.0,
//                     child: FBoundingBox(
//                       size: FBoxSize.size16x16,
//                       type: FBoundingBoxType.circle,
//                       backgroundColor: doc.status['color'],
//                       child: FIcon(
//                         icon: doc.status['icon'],
//                         size: 10.0,
//                         color: [FColors.grey1, doc.status['color']],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//           title: FText(
//             doc.filename,
//             style: FTextStyle.bodyText2,
//             color: SkinColor.title,
//             softWrap: true,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           subtitle: FText(
//             "${doc.uploadUser}, ${doc.createdDate.toString().substring(0, 19)}",
//             style: FTextStyle.subtitle2,
//             color: SkinColor.subTitle,
//             maxLines: 1,
//           ),
//           action: [
//             FIconButton(
//               size: FIconButtonSize.size32,
//               icon: FOutlinedIcons.ellipsis,
//               backgroundColor: FColors.transparent,
//               color: FColors.grey10,
//               onPressed: () {
//                 // showAction(context, doc);
//               },
//             )
//           ],
//           onTap: () {
//             SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//             Navigator.push(
//               context,
//               MaterialPageRoute<void>(
//                 builder: (context) => DocumentDetailScreen(
//                   heroTag: doc.fileId,
//                   image: doc.thumbnailInvoice,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// showAction(BuildContext context, DocumentItem doc) {
//   showModalBottomSheet(
//     elevation: 0,
//     isDismissible: true,
//     enableDrag: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(12),
//         topRight: Radius.circular(12),
//       ),
//     ),
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 color: FColors.grey1,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   FIconButton(
//                     color: FColors.grey10,
//                     icon: FOutlinedIcons.close,
//                     backgroundColor: FColors.transparent,
//                     buttonStyle: FIconButtonStyle.iconAction,
//                     size: FIconButtonSize.size48,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Expanded(
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: FText(
//                         "Tác vụ",
//                         style: FTextStyle.titleModules3,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 48,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   FListTitle(
//                     title: FText("Chia sẻ"),
//                     height: 48,
//                     avatar: FBoundingBox(
//                       size: FBoxSize.size32x32,
//                       type: FBoundingBoxType.circle,
//                       backgroundColor: FColors.green1,
//                       child: FIcon(
//                         icon: FOutlinedIcons.share_alt,
//                         color: [FColors.green6],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
