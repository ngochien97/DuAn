// import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
// import 'package:Framework/FDA/Providers/FileProvider.dart';
// import 'package:Framework/FIS.SYS/Skins/Icon.dart';
// import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
// import 'package:Framework/FIS.SYS/Skins/Typography.dart';
// import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// filter(BuildContext context, name) {
//   //void
//   showModalBottomSheet(
//     context: context,
//     builder: (contex) => FBottomSheet(
//       header: FModal(
//         title: FText(
//           'Sắp xếp',
//           style: FTextStyle.buttonText1,
//         ),
//       ),
//       body: Container(
//         child: Consumer<FileProvider>(
//           builder: (context, documentProvider, child) => Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   documentProvider.setSortType(1);
//                   Navigator.pop(context);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Mới nhất'),
//                   action: [
//                     documentProvider.sortType == 1
//                         ? FIcon(
//                             icon: FOutlinedIcons.check,
//                             color: [SkinColor.titleBack, FColors.transparent],
//                             size: 16,
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   documentProvider.setSortType(2);
//                   Navigator.pop(context);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Cũ nhất'),
//                   action: [
//                     documentProvider.sortType == 2
//                         ? FIcon(
//                             icon: FOutlinedIcons.check,
//                             color: [SkinColor.titleBack, FColors.transparent],
//                             size: 16,
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   documentProvider.setSortType(3);
//                   Navigator.pop(context);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Theo tên ( từ A đến Z)'),
//                   action: [
//                     documentProvider.sortType == 3
//                         ? FIcon(
//                             icon: FOutlinedIcons.check,
//                             color: [SkinColor.titleBack, FColors.transparent],
//                             size: 16,
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   documentProvider.setSortType(4);
//                   Navigator.pop(context);
//                 },
//                 child: FListTitle(
//                   title: FText('Theo tên ( từ Z đến A)'),
//                   action: [
//                     documentProvider.sortType == 4
//                         ? FIcon(
//                             icon: FOutlinedIcons.check,
//                             color: [SkinColor.titleBack, FColors.transparent],
//                             size: 16,
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
