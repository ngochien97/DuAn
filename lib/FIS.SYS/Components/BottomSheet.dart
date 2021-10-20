import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class FModal extends StatelessWidget {
  final Widget iconAction;
  final FText title;
  final bool centerTitle;
  final FBoundingBox avatar;
  final FText subtitle;
  final Widget bottom;
  final Widget textAction;

  FModal({
    this.iconAction,
    @required this.title,
    this.subtitle,
    this.avatar,
    this.centerTitle = false,
    this.textAction,
    this.bottom,
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
              children: [
                FIconButton(
                  icon: FOutlinedIcons.close,
                  color: FColors.grey9,
                  size: FIconButtonSize.size48,
                  buttonStyle: FIconButtonStyle.solid,
                  backgroundColor: FColors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  width: 0.66 * MediaQuery.of(context).size.width,
                  alignment: centerTitle == true
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Wrap(
                    children: [
                      avatar != null ? avatar : SizedBox(),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                child: title,
                              ),
                              subtitle != null
                                  ? Container(
                                      child: subtitle,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                textAction != null
                    ? textAction
                    : Container(
                        width: 0.12 * MediaQuery.of(context).size.width,
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
  final Color backgroundColor;
  final double height;
  final double initialChildSize;
  final bool enableDrag;
  final Widget bottom;

  FBottomSheet(
      {this.height = 104.0,
      this.body,
      this.initialChildSize = 0.4,
      this.header,
      this.bottom,
      this.enableDrag = true,
      this.backgroundColor = FColors.grey1});

  static showFBottomSheet(context, FBottomSheet bottomSheet) =>
      showModalBottomSheet(
          backgroundColor: FColors.transparent,
          isScrollControlled: true,
          elevation: 0,
          context: context,
          builder: (context) => bottomSheet);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        expand: false,
        minChildSize: 0.2,
        maxChildSize: enableDrag == false ? initialChildSize : 0.95,
        builder: (context, scrollController) => Scaffold(
              backgroundColor: FColors.transparent,
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(header.bottom != null ? height : 64.0),
                child: AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: SafeArea(
                    child: header != null ? header : SizedBox(),
                  ),
                  backgroundColor: FColors.transparent,
                ),
              ),
              body: enableDrag == false
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: backgroundColor,
                            child: body != null ? body : SizedBox(),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      controller: scrollController,
                      children: [
                        Container(
                          color: backgroundColor,
                          height: MediaQuery.of(context).size.height,
                          child: body != null ? body : SizedBox(),
                        ),
                      ],
                    ),
              bottomNavigationBar: bottom,
            ));
  }
}
