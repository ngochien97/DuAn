// import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
// import 'package:Framework/FIS.SYS/Skins/Typography.dart';
// import 'package:Framework/FIS.SYS/Styles/Colors.dart';
// import 'package:Framework/FIS.SYS/Styles/Icons.dart';
// import 'package:flutter/material.dart';

// class FNavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String subtitle;
//   final bool centerTitle;
//   final Widget leading;
//   final List<Widget> actions;
//   final Widget flexibleSpace;
//   final Widget bottom;
//   final FAppBarSize size;
//   final FBoundingBox avatar;
//   final bool rightAvatar;
//   final String parentTitle;
//   final FAppBarBackground background;
//   final Color backgroundColor;
//   final Color titleColor;
//   final Color subtitleColor;
//   final Color parentTitleColor;
//   final bool hideLeading;
//   final double height;
//   final FTextStyle titleFont;
//   final bool shortenLargeAppBar;

//   const FNavigationAppBar({
//     this.title,
//     this.subtitle,
//     this.actions,
//     this.hideLeading = false,
//     this.bottom,
//     this.centerTitle,
//     this.titleFont,
//     this.flexibleSpace,
//     this.parentTitle,
//     this.height,
//     this.titleColor,
//     this.parentTitleColor,
//     this.subtitleColor,
//     this.avatar,
//     this.backgroundColor,
//     this.rightAvatar,
//     this.shortenLargeAppBar = false,
//     this.leading,
//     this.background = FAppBarBackground.light,
//     this.size = FAppBarSize.small,
//   });

//   Widget smallCenterTitle(BuildContext context) => Container(
//       width: 0.7 * MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           hideLeading == true
//               ? SizedBox()
//               : leading != null
//                   ? leading
//                   : FIconButton(
//                       icon: FOutlinedIcons.left,
//                       backgroundColor: FColors.transparent,
//                       color: background.getColor['color'],
//                       size: FIconButtonSize.size48,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//           Expanded(
//               child: Center(
//             child: Column(
//               children: [
//                 Wrap(
//                   children: [
//                     FText(
//                       value: title,
//                       color: titleColor != null
//                           ? titleColor
//                           : background.getColor['color'],
//                       style: titleFont != null
//                           ? titleFont
//                           : FTextStyle.buttonText1,
//                     ),
//                   ],
//                 ),
//                 subtitle != null
//                     ? FText(
//                         value: subtitle,
//                         color: subtitleColor != null
//                             ? subtitleColor
//                             : background.getColor['color'],
//                         style: FTextStyle.subtitle2,
//                       )
//                     : SizedBox(
//                         width: 1,
//                       ),
//               ],
//             ),
//           ))
//         ],
//       ));
//   Widget smallLeftTitle(BuildContext context) => Container(
//       width: 0.7 * MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           hideLeading == true
//               ? SizedBox()
//               : leading != null
//                   ? leading
//                   : Container(
//                       margin: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: FBoundingBox(
//                         child: Container(
//                           color: FColors.grey4,
//                         ),
//                         size: FBoxSize.size_32px,
//                       )),
//           Expanded(
//             child: Column(
//               children: [
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Wrap(
//                     children: [
//                       FText(
//                           value: title,
//                           color: titleColor != null
//                               ? titleColor
//                               : background.getColor['color'],
//                           style: titleFont != null
//                               ? titleFont
//                               : FTextStyle.buttonText1),
//                     ],
//                   ),
//                 ),
//                 subtitle != null
//                     ? Container(
//                         alignment: Alignment.centerLeft,
//                         child: FText(
//                             value: subtitle,
//                             color: subtitleColor != null
//                                 ? subtitleColor
//                                 : background.getColor['color'],
//                             style: FTextStyle.subtitle2),
//                       )
//                     : SizedBox(
//                         width: 1,
//                       ),
//               ],
//             ),
//           )
//         ],
//       ));
//   List<Widget> smallDefaultActions() => [
//         FIconButton(
//           icon: FOutlinedIcons.cloud_upload,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//         FIconButton(
//           icon: FOutlinedIcons.camera,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//       ];

//   Widget smallAppBar(BuildContext context) => Column(
//         children: [
//           Container(
//             child: Row(
//               children: [
//                 centerTitle != true
//                     ? smallLeftTitle(context)
//                     : smallCenterTitle(context),
//                 Container(
//                   child: Row(
//                     children: actions != null ? actions : smallDefaultActions(),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           bottom != null ? bottom : SizedBox(),
//         ],
//       );
//   Widget largeRightAvatar() => Container(
//         margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Flexible(
//               flex: 7,
//               child: Wrap(
//                 children: [
//                   FText(
//                     value: title,
//                     color: titleColor != null
//                         ? titleColor
//                         : background.getColor['color'],
//                     style:
//                         titleFont != null ? titleFont : FTextStyle.largeTitle2,
//                   ),
//                 ],
//               ),
//             ),
//             Flexible(
//               flex: 2,
//               child: avatar != null
//                   ? avatar
//                   : FBoundingBox(
//                       child: Container(color: FColors.grey4),
//                       size: FBoxSize.size_40px,
//                     ),
//             )
//           ],
//         ),
//       );
//   Widget largeLeftAvatar() => Container(
//         margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
//         child: Row(
//           children: [
//             Container(
//               margin: EdgeInsets.only(right: 12.0),
//               child: avatar != null ? avatar : SizedBox(),
//             ),
//             Expanded(
//               child: Wrap(
//                 children: [
//                   FText(
//                     value: title,
//                     color: titleColor != null
//                         ? titleColor
//                         : background.getColor['color'],
//                     style:
//                         titleFont != null ? titleFont : FTextStyle.largeTitle2,
//                     maxLines: 2,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );

//   List<Widget> largeDefaultActions() => [
//         FIconButton(
//           icon: FOutlinedIcons.sort_ascending,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//         FIconButton(
//           icon: FOutlinedIcons.cloud_upload,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//         FIconButton(
//           icon: FOutlinedIcons.camera,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//         FIconButton(
//           icon: FOutlinedIcons.plus,
//           backgroundColor: FColors.transparent,
//           color: background.getColor['color'],
//           size: FIconButtonSize.size48,
//           onPressed: () {},
//         ),
//       ];

//   Widget largeAppBar(BuildContext context) => Column(
//         children: [
//           shortenLargeAppBar == true
//               ? SizedBox()
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                         width: 0.45 * MediaQuery.of(context).size.width,
//                         child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: parentTitle != null
//                               ? FButton(
//                                   title: parentTitle,
//                                   backgroundColor: FColors.transparent,
//                                   size: FButtonSize.size48,
//                                   leftIcon: FOutlinedIcons.left,
//                                   color: parentTitleColor != null
//                                       ? parentTitleColor
//                                       : background.getColor['color'],
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   tapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                 )
//                               : FIconButton(
//                                   icon: FOutlinedIcons.left,
//                                   backgroundColor: FColors.transparent,
//                                   size: FIconButtonSize.size48,
//                                   color: parentTitleColor != null
//                                       ? parentTitleColor
//                                       : background.getColor['color'],
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   tapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                 ),
//                         )),
//                     Container(
//                       child: Row(
//                         children:
//                             actions != null ? actions : largeDefaultActions(),
//                       ),
//                     ),
//                   ],
//                 ),
//           rightAvatar != null ? largeRightAvatar() : largeLeftAvatar(),
//           bottom != null ? bottom : SizedBox(),
//         ],
//       );

//   Widget flexSpace() => PreferredSize(
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           brightness: background.getColor['brightness'],
//           backgroundColor: backgroundColor != null
//               ? backgroundColor
//               : background.getColor['backgroundColor'],
//           flexibleSpace: SafeArea(child: flexibleSpace),
//         ),
//         preferredSize: Size.fromHeight(height != null ? height : 120),
//       );

//   @override
//   Widget build(BuildContext context) {
//     var checkSize = size.getSize['checkSize'];
//     return flexibleSpace != null
//         ? flexSpace()
//         : AppBar(
//             automaticallyImplyLeading: false,
//             brightness: background.getColor['brightness'],
//             backgroundColor: backgroundColor != null
//                 ? backgroundColor
//                 : background.getColor['backgroundColor'],
//             flexibleSpace: SafeArea(
//               child: Container(
//                   color: backgroundColor != null
//                       ? backgroundColor
//                       : background.getColor['backgroundColor'],
//                   child: checkSize == true
//                       ? smallAppBar(context)
//                       : largeAppBar(context)),
//             ),
//           );
//   }

//   double defaultHeight() {
//     switch (bottom) {
//       case null:
//         return size.getSize['height'];
//         break;
//       default:
//         return (size.getSize['height'] + 50);
//     }
//   }

//   @override
//   Size get preferredSize =>
//       Size.fromHeight(height != null ? height : defaultHeight());
// }

// enum FAppBarSize {
//   small,
//   large,
// }

// extension FAppBarSizeExtension on FAppBarSize {
//   static var size = {
//     FAppBarSize.small: {'checkSize': true, 'height': 50.0},
//     FAppBarSize.large: {'checkSize': false, 'height': 108.0},
//   };
//   get getSize => size[this];
// }

// enum FAppBarBackground {
//   light,
//   dark,
// }

// extension FAppBarBackgroundExtension on FAppBarBackground {
//   static var color = {
//     FAppBarBackground.dark: {
//       'color': FColors.grey1,
//       'backgroundColor': FColors.grey9,
//       'brightness': Brightness.dark
//     },
//     FAppBarBackground.light: {
//       'color': FColors.grey9,
//       'backgroundColor': FColors.grey1,
//       'brightness': Brightness.light
//     },
//   };
//   get getColor => color[this];
// }
