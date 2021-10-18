import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import 'ComponentsBase.dart';

class FPopupActionSheet {
  final List<FPopupAction> actions;
  final FText message;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color backgroundColor;

  FPopupActionSheet({
    this.actions,
    this.message,
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor = FColors.grey1,
  });
}

class FPopupAction extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color backgroundColor;
  final Color color;

  const FPopupAction({
    @required this.title,
    this.backgroundColor = FColors.grey1,
    this.color = FColors.blue6,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(
          bottom: 12.0,
        ),
        child: FButton(
          title: title,
          backgroundColor: backgroundColor,
          color: color,
          size: FButtonSize.size48,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          block: true,
          onPressed: onPressed,
        ),
      );
}

void showFPopupActionSheet(
    BuildContext context, FPopupActionSheet popupActionSheet) {
  showModalBottomSheet(
    backgroundColor: FColors.transparent,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        margin: popupActionSheet.margin,
        padding: popupActionSheet.padding,
        decoration: BoxDecoration(
          borderRadius: popupActionSheet.borderRadius,
          color: popupActionSheet.backgroundColor,
        ),
        child: Column(
          children: [
            popupActionSheet.message != null
                ? Container(
                    margin: const EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: popupActionSheet.message)
                : const SizedBox(),
            Column(
              children: popupActionSheet.actions,
            ),
          ],
        ),
      ),
    ),
  );
}
