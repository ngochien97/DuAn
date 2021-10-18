import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import '../Styles/Icons.dart';
import 'ComponentsBase.dart';

class FModal extends StatelessWidget {
  final Widget iconAction;
  final Widget title;
  final Widget bottom;
  final Widget textAction;
  final Alignment titleAlignment;

  const FModal({
    @required this.title,
    this.iconAction,
    this.textAction,
    this.bottom,
    this.titleAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: FColors.grey1,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconAction ??
                      FIconButton(
                        icon: FOutlinedIcons.close,
                        color: FColors.grey9,
                        size: FIconButtonSize.size48,
                        backgroundColor: FColors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                  Expanded(
                    child: Container(
                      alignment: titleAlignment,
                      child: title,
                    ),
                  ),
                  textAction ??
                      Container(
                        width: 48.0,
                      )
                ],
              ),
            ),
            bottom != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 8.0), child: bottom)
                : const SizedBox(),
            const FDivider(),
          ],
        ),
      );
}

class FBottomSheet extends StatelessWidget {
  final FModal header;
  final Widget body;
  final MainAxisSize mainAxisSize;

  const FBottomSheet(
      {this.header, this.body, this.mainAxisSize = MainAxisSize.min});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
        child: Column(
          mainAxisSize: mainAxisSize,
          children: [
            header ?? Container(),
            Container(child: body ?? Container()),
          ],
        ),
      );
}
