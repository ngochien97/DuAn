import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import '../Styles/Effect.dart';
import 'ComponentsBase.dart';

class FSwitch extends StatefulWidget {
  final String activeContainLabel;
  final String inActiveContainLabel;
  final String label;
  final MaterialTapTargetSize tapTargetSize;
  final Color activeBackgroundColor;
  final Color inActiveBackgroundColor;
  final Color trackColor;
  final Function onChanged;
  final bool value;

  const FSwitch({
    @required this.value,
    @required this.onChanged,
    this.label,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.activeBackgroundColor = FColors.blue6,
    this.inActiveBackgroundColor = FColors.grey4,
    this.trackColor = FColors.grey1,
    this.activeContainLabel,
    this.inActiveContainLabel,
  });

  @override
  _FSwitchState createState() => _FSwitchState();
}

class _FSwitchState extends State<FSwitch> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.onChanged == null) {
                return;
              }
              setState(() {
                widget.onChanged(!widget.value);
              });
            },
            onPanUpdate: (details) {
              if (widget.onChanged == null) {
                return;
              }
              if (details.delta.dx > 0) {
                setState(() {
                  widget.onChanged(true);
                });
              }
              if (details.delta.dx < 0) {
                setState(() {
                  widget.onChanged(false);
                });
              }
            },
            onPanEnd: (details) {
              if (widget.onChanged == null) {
                return;
              }
              widget.onChanged(widget.value);
            },
            child: Container(
              color: FColors.transparent,
              child: Container(
                height: 24,
                width: widget.activeContainLabel != null &&
                        widget.inActiveContainLabel != null
                    ? 60
                    : 44,
                padding: const EdgeInsets.all(2),
                margin: widget.tapTargetSize == MaterialTapTargetSize.padded
                    ? const EdgeInsets.symmetric(vertical: 12, horizontal: 2)
                    : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: widget.value == true
                      ? widget.onChanged != null
                          ? widget.activeBackgroundColor
                          : FColors.blue4
                      : widget.onChanged != null
                          ? widget.inActiveBackgroundColor
                          : FColors.grey3,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: widget.value == true
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.trackColor,
                        boxShadow: [FEffect.elevation3],
                      ),
                    ),
                    widget.activeContainLabel != null &&
                            widget.inActiveContainLabel != null
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 22,
                            width: 28,
                            alignment: Alignment.center,
                            child: FText(
                              widget.value == true
                                  ? widget.activeContainLabel
                                  : widget.inActiveContainLabel,
                              color: FColors.grey1,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          widget.label != null
              ? Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: FText(
                      widget.label,
                      maxLines: 2,
                      color: widget.onChanged == null ? FColors.grey6 : null,
                    ),
                  ),
                )
              : Container(),
        ],
      );
}
