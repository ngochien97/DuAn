import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FRadioButton extends StatefulWidget {
  final dynamic value;
  final dynamic groupValue;
  final Function onChanged;
  final String label;
  final Color activeColor;
  final MaterialTapTargetSize tapTargetSize;
  final bool toggle;
  FRadioButton({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.groupValue,
    this.label,
    this.activeColor = FColors.blue6,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.toggle,
  }) : super(key: key);

  @override
  _FRadioButtonState createState() => _FRadioButtonState();
}

class _FRadioButtonState extends State<FRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged == null) {
          return;
        }
        if (widget.value == widget.groupValue && widget.toggle == true) {
          widget.onChanged(null);
        } else {
          widget.onChanged(widget.value);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            child: Container(
              height: 24,
              width: 24,
              margin: widget.tapTargetSize == MaterialTapTargetSize.padded
                  ? EdgeInsets.all(12)
                  : EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.onChanged != null
                      ? widget.value == widget.groupValue
                          ? widget.activeColor
                          : FColors.grey6
                      : widget.value == widget.groupValue
                          ? FColors.grey6
                          : FColors.grey5,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: widget.value == widget.groupValue
                  ? Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.onChanged != null
                            ? widget.activeColor
                            : FColors.grey6,
                      ),
                    )
                  : Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.onChanged != null ? null : FColors.grey3,
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
                      style: FTextStyle.bodyText2,
                      color: widget.onChanged == null ? FColors.grey6 : null,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
