import 'package:Framework/FIS.SYS/Components/Divider.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class FTextField extends StatefulWidget {
  final FTextFieldSize size;
  final String value;
  final String label;
  final TextInputType keyboardType;
  final bool validator;
  final Function onChanged;
  final Function onSubmitted;
  final Function onRightIconPressed;
  final String message;
  final bool enabled;
  final String leftIcon;
  final String rightIcon;
  final bool clearable;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Color textColor;
  final Color backgroundColor;
  final bool autoFocus;

  FTextField({
    Key key,
    this.size = FTextFieldSize.size32,
    this.value,
    this.label,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.message,
    this.enabled = true,
    this.onRightIconPressed,
    this.leftIcon,
    this.rightIcon,
    this.clearable = false,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textColor = FColors.grey7,
    this.backgroundColor = FColors.grey1,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  _FTextFieldState createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  TextEditingController _controller = new TextEditingController();
  FTextFieldStatus status = FTextFieldStatus.normal;
  bool isFocused = false;

  @override
  void initState() {
    _controller.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> textFieldState;
    switch (widget.size) {
      case FTextFieldSize.size32:
        textFieldState = {
          'size': 30.0,
        };
        break;
      case FTextFieldSize.size40:
        textFieldState = {
          'size': 40.0,
        };
        break;
      case FTextFieldSize.size56:
        textFieldState = {
          'size': 56.0,
        };
        break;
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(color: status.color),
              color: widget.enabled ? widget.backgroundColor : FColors.grey3,
            ),
            height: textFieldState['size'],
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.leftIcon != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: FIcon(
                          icon: widget.leftIcon,
                          size: 16,
                          color: [FColors.grey7],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                      ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.size == FTextFieldSize.size56 &&
                              (isFocused == true || _controller.text != "")
                          ? Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: FText(
                                widget.label,
                                color: widget.textColor,
                                style: FTextStyle.subtitle2,
                              ),
                            )
                          : Container(),
                      Focus(
                        onFocusChange: (value) {
                          setState(() {
                            isFocused = value;
                            if (value && status == FTextFieldStatus.normal) {
                              status = FTextFieldStatus.focus;
                            } else if (!value &&
                                status == FTextFieldStatus.focus) {
                              status = FTextFieldStatus.normal;
                            }
                          });
                        },
                        child: TextField(
                          autofocus: widget.autoFocus,
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.size == FTextFieldSize.size56 &&
                                    isFocused == true
                                ? null
                                : widget.label,
                            hintStyle: FTextStyle.bodyText2.textStyle.copyWith(
                              color: widget.enabled
                                  ? FColors.grey7
                                  : FColors.grey6,
                            ),
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                          ),
                          textCapitalization: widget.textCapitalization,
                          obscureText: widget.obscureText,
                          cursorColor: FColors.grey10,
                          cursorWidth: 1,
                          style: FTextStyle.bodyText2.textStyle.copyWith(
                            color: widget.enabled
                                ? widget.textColor
                                : FColors.grey7,
                          ),
                          enabled: widget.enabled,
                          keyboardType: widget.keyboardType,
                          onChanged: (String value) {
                            widget.onChanged(value);
                          },
                          onSubmitted: (value) {
                            widget.onSubmitted(value);
                            if (widget.validator) {
                              status = FTextFieldStatus.success;
                            } else {
                              status = FTextFieldStatus.error;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                widget.clearable == true
                    ? Container(
                        padding: EdgeInsets.only(right: 8, left: 16),
                        child: FIcon(
                          onPressed: () {
                            if (widget.enabled) {
                              if (widget.value != null || widget.value != "") {
                                _controller.clear();
                                widget.onChanged(_controller.text);
                                if (!isFocused) {
                                  setState(() {
                                    status = FTextFieldStatus.normal;
                                  });
                                }
                              }
                            }
                          },
                          icon: FFilledIcons.close_circle,
                          size: 16,
                          color: [FColors.grey6],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(right: 8),
                      ),
                widget.clearable == true && widget.rightIcon != null
                    ? FDivider(
                        vertical: true,
                        height: 12,
                        color: FColors.grey4,
                      )
                    : Container(),
                widget.rightIcon != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: FIcon(
                          onPressed: () {
                            if (widget.enabled) {
                              widget.onRightIconPressed();
                            }
                          },
                          icon: widget.rightIcon,
                          size: 16,
                          color: [FColors.grey7],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          widget.message != null
              ? Container(
                  margin: EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: FText(
                    widget.message,
                    color: status == FTextFieldStatus.normal
                        ? FColors.grey7
                        : status.color,
                    style: FTextStyle.subtitle2,
                    maxLines: 2,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

enum FTextFieldSize {
  size32,
  size40,
  size56,
}

enum FTextFieldStatus {
  normal,
  success,
  error,
  focus,
}

extension FTextFieldStatusExtension on FTextFieldStatus {
  static const colorValues = {
    FTextFieldStatus.normal: FColors.grey4,
    FTextFieldStatus.success: FColors.green6,
    FTextFieldStatus.error: FColors.red6,
    FTextFieldStatus.focus: FColors.blue6,
  };

  Color get color => colorValues[this];
}
