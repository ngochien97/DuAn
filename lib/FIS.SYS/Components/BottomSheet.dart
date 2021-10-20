import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class FModal extends StatelessWidget {
  final Widget iconAction;
  final Widget title;
  final Widget bottom;
  final Widget textAction;
  final Alignment titleAlignment;

  FModal({
    this.iconAction,
    @required this.title,
    this.textAction,
    this.bottom,
    this.titleAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: FColors.grey1,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconAction != null
                    ? iconAction
                    : FIconButton(
                        icon: FOutlinedIcons.close,
                        color: FColors.grey9,
                        size: FIconButtonSize.size48,
                        buttonStyle: FIconButtonStyle.solid,
                        backgroundColor: FColors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                Expanded(
                  child: Container(
                    child: title,
                    alignment: titleAlignment,
                  ),
                ),
                textAction != null
                    ? textAction
                    : Container(
                        width: 48.0,
                      )
              ],
            ),
          ),
          bottom != null
              ? Container(margin: EdgeInsets.only(bottom: 8.0), child: bottom)
              : SizedBox(),
          FDivider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class FBottomSheet extends StatelessWidget {
  final FModal header;
  final Widget body;
  final MainAxisSize mainAxisSize;
  FBottomSheet({this.header, this.body, this.mainAxisSize = MainAxisSize.min});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      child: Column(
        mainAxisSize: mainAxisSize,
        children: [
          header != null ? header : Container(),
          Container(child: body != null ? body : Container()),
        ],
      ),
    );
  }
}
// class FBottomSheet extends StatefulWidget {
//   final FModal header;
//   final Widget body;
//   final Color backgroundColor;
//   final double height;
//   final double initialChildSize;
//   final bool enableDrag;
//   final Widget bottom;

//   FBottomSheet(
//       {this.height = 104.0,
//       this.body,
//       this.initialChildSize = 0.4,
//       this.header,
//       this.bottom,
//       this.enableDrag = true,
//       this.backgroundColor = FColors.grey1});

//   static showFBottomSheet(context, FBottomSheet bottomSheet) =>
//       showModalBottomSheet(
//           backgroundColor: FColors.transparent,
//           isScrollControlled: true,
//           elevation: 0,
//           context: context,
//           builder: (context) {
//             return StatefulBuilder(
//               builder: (context, setState) => bottomSheet,
//             );
//           });

//   @override
//   _FBottomSheetState createState() => _FBottomSheetState();
// }

// class _FBottomSheetState extends State<FBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       initialChildSize: widget.initialChildSize,
//       expand: false,
//       minChildSize: 0.2,
//       maxChildSize: widget.enableDrag == false ? widget.initialChildSize : 0.95,
//       builder: (context, scrollController) => Scaffold(
//         backgroundColor: FColors.transparent,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//               widget.header.bottom != null ? widget.height : 64.0),
//           child: AppBar(
//             elevation: 0.0,
//             automaticallyImplyLeading: false,
//             flexibleSpace: SafeArea(
//               child: widget.header != null ? widget.header : SizedBox(),
//             ),
//             backgroundColor: FColors.transparent,
//           ),
//         ),
//         body: widget.enableDrag == false
//             ? Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       color: widget.backgroundColor,
//                       child: widget.body != null ? widget.body : SizedBox(),
//                     ),
//                   ),
//                 ],
//               )
//             : ListView(
//                 controller: scrollController,
//                 children: [
//                   Container(
//                     color: widget.backgroundColor,
//                     height: MediaQuery.of(context).size.height,
//                     child: widget.body != null ? widget.body : SizedBox(),
//                   ),
//                 ],
//               ),
//         bottomNavigationBar: widget.bottom,
//       ),
//     );
//   }
// }
