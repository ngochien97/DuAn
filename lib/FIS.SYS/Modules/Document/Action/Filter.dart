// import 'package:Framework/FDA/Providers/DocumentProvider.dart';
// import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
// import 'package:Framework/FIS.SYS/Skins/Icon.dart';
// import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
// import 'package:Framework/FIS.SYS/Skins/Typography.dart';
// import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../FDA/Providers/DocumentProvider.dart';

// filter(BuildContext context, name) {
//   //void
//   return FBottomSheet.showFBottomSheet(
//     context,
//     FBottomSheet(
//       enableDrag: false,
//       header: FModal(
//         title: FText(
//           'Sắp xếp',
//           style: FTextStyle.buttonText1,
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Consumer<DocumentProvider>(
//           builder: (context, documentProvider, child) => Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   documentProvider.setSort(1);
//                   Navigator.pushReplacementNamed(
//                       context, '/detailFolder_screen',
//                       arguments: name);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Mới nhất'),
//                   action: [
//                     documentProvider.getSort == 1
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
//                   documentProvider.setSort(2);
//                   Navigator.pushReplacementNamed(
//                       context, '/detailFolder_screen',
//                       arguments: name);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Cũ nhất'),
//                   action: [
//                     documentProvider.getSort == 2
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
//                   documentProvider.setSort(3);
//                   Navigator.pushReplacementNamed(
//                       context, '/detailFolder_screen',
//                       arguments: name);
//                 },
//                 child: FListTitle(
//                   dividerIndent: true,
//                   title: FText('Theo tên ( từ A đến Z)'),
//                   action: [
//                     documentProvider.getSort == 3
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
//                   documentProvider.setSort(4);
//                   Navigator.pushReplacementNamed(
//                       context, '/detailFolder_screen',
//                       arguments: name);
//                 },
//                 child: FListTitle(
//                   title: FText('Theo tên ( từ Z đến A)'),
//                   action: [
//                     documentProvider.getSort == 4
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
