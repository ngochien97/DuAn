import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';

class FCheckbox extends StatefulWidget {
  final Function onChanged;
  final bool value;
  final String label;
  final FCheckboxSize size;
  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize tapTargetSize;

  FCheckbox({
    @required this.value,
    @required this.onChanged,
    this.label,
    this.size = FCheckboxSize.size20,
    this.activeColor = FColors.blue6,
    this.checkColor = FColors.grey1,
    this.tapTargetSize = MaterialTapTargetSize.padded,
  });

  @override
  _FCheckboxState createState() => _FCheckboxState();
}

class _FCheckboxState extends State<FCheckbox> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> checkBoxState;
    switch (widget.size) {
      case FCheckboxSize.size16:
        checkBoxState = {
          'height': 16.0,
          'margin': 16.0,
          'iconSize': 10.67,
        };
        break;
      case FCheckboxSize.size20:
        checkBoxState = {
          'height': 20.0,
          'margin': 14.0,
          'iconSize': 13.33,
        };
        break;
      case FCheckboxSize.size24:
        checkBoxState = {
          'height': 24.0,
          'margin': 12.0,
          'iconSize': 16.0,
        };
        break;
    }
    return GestureDetector(
      onTap: () {
        if (widget.onChanged == null) {
          return;
        }
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            child: widget.value == true
                ? Container(
                    height: checkBoxState['height'],
                    width: checkBoxState['height'],
                    margin: widget.tapTargetSize == MaterialTapTargetSize.padded
                        ? EdgeInsets.only(
                            top: checkBoxState['margin'],
                            bottom: checkBoxState['margin'],
                            left: checkBoxState['margin'],
                            right: widget.label == null
                                ? checkBoxState['margin']
                                : 12,
                          )
                        : EdgeInsets.all(0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.onChanged == null
                          ? FColors.grey6
                          : widget.activeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FIcon(
                      icon: FOutlinedIcons.check,
                      size: checkBoxState['iconSize'],
                      color: [widget.checkColor],
                    ),
                  )
                : Container(
                    height: checkBoxState['height'],
                    width: checkBoxState['height'],
                    margin: widget.tapTargetSize == MaterialTapTargetSize.padded
                        ? EdgeInsets.only(
                            top: checkBoxState['margin'],
                            bottom: checkBoxState['margin'],
                            left: checkBoxState['margin'],
                            right: widget.label == null
                                ? checkBoxState['margin']
                                : 12,
                          )
                        : EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 2,
                        color: widget.onChanged == null
                            ? FColors.grey5
                            : FColors.grey6,
                      ),
                    ),
                  ),
          ),
          widget.label != null
              ? Expanded(
                  child: Container(
                    margin:
                        widget.tapTargetSize == MaterialTapTargetSize.shrinkWrap
                            ? EdgeInsets.only(left: 12)
                            : null,
                    child: FText(
                      widget.label,
                      maxLines: 2,
                      color: widget.onChanged == null ? FColors.grey6 : null,
                      style: FTextStyle.bodyText2,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

enum FCheckboxSize { size16, size20, size24 }
