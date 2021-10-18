import 'package:flutter/material.dart';

import '../../F.Utils/SrceenExtensions.dart';
import '../Skins/Icon.dart';
import '../Skins/Typography.dart';
import '../Styles/StyleBase.dart';
import 'ComponentsBase.dart';

// ignore: must_be_immutable
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
  final TextEditingController controller;
  final Function onFocus;
  FTextFieldStatus status;

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
    this.controller,
    this.onFocus,
    this.status = FTextFieldStatus.normal,
  }) : super(key: key);

  @override
  _FTextFieldState createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  // TextEditingController widget.controller = new TextEditingController();
  bool isFocused = false;

  Color getColor() {
    switch (widget.status) {
      case FTextFieldStatus.normal:
        return FColors.grey4;
        break;
      case FTextFieldStatus.success:
        return FColors.green6;
        break;
      case FTextFieldStatus.error:
        return FColors.red6;
        break;
      case FTextFieldStatus.focus:
        return FColors.blue6;
        break;
      default:
        return FColors.grey4;
        break;
    }
  }

  @override
  void initState() {
    // widget.controller.text = widget.value;
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
      case FTextFieldSize.size48:
        textFieldState = {
          'size': 48.0,
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
              border: Border.all(color: isFocused ? FColors.blue6 : getColor()),
              color: widget.enabled ? widget.backgroundColor : FColors.grey3,
            ),
            height: textFieldState['size'] as double,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                widget.leftIcon != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: FIcon(
                          icon: widget.leftIcon,
                          size: 16.h,
                          color: const <Color>[FColors.grey7],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.size == FTextFieldSize.size56 &&
                              (isFocused == true || widget.value != '')
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              child: FText(
                                widget.label,
                                color: widget.textColor,
                                style: FTextStyle.subtitle2,
                              ),
                            )
                          : Container(),
                      Focus(
                        onFocusChange: (value) {
                          isFocused = value;
                          widget.onFocus(value);
                          setState(() {
                            if (value &&
                                widget.status == FTextFieldStatus.normal) {
                              widget.status = FTextFieldStatus.focus;
                            } else if (!value &&
                                widget.status == FTextFieldStatus.focus) {
                              widget.status = FTextFieldStatus.normal;
                            }
                          });
                        },
                        child: TextField(
                          autofocus: widget.autoFocus,
                          controller: widget.controller,
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
                            contentPadding: const EdgeInsets.all(0),
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
                            if (widget.onChanged != null) {
                              widget.onChanged(value);
                            }
                          },
                          onSubmitted: (value) {
                            widget.onSubmitted(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                widget.clearable == true
                    ? Container(
                        padding: const EdgeInsets.only(right: 8, left: 16),
                        child: FIcon(
                          onPressed: () {
                            if (widget.enabled) {
                              if (widget.value != null || widget.value != '') {
                                widget.controller.clear();
                                widget.onChanged(widget.controller.text);
                                if (!isFocused) {
                                  setState(() {
                                    widget.status = FTextFieldStatus.normal;
                                  });
                                }
                              }
                            }
                          },
                          icon: FFilledIcons.close_circle,
                          size: 16.h,
                          color: const <Color>[FColors.grey6],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(right: 8),
                      ),
                widget.clearable == true && widget.rightIcon != null
                    ? FDivider(
                        vertical: true,
                        height: 12.h,
                      )
                    : Container(),
                widget.rightIcon != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: FIcon(
                          onPressed: () {
                            if (widget.enabled) {
                              widget.onRightIconPressed();
                            }
                          },
                          icon: widget.rightIcon,
                          size: 16.h,
                          color: const <Color>[FColors.grey7],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          widget.message != null
              ? Container(
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: FText(
                    widget.message,
                    color: getColor(),
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
  size48,
  size56,
}

enum FTextFieldStatus {
  normal,
  success,
  error,
  focus,
}

// extension FTextFieldStatusExtension on FTextFieldStatus {
//   static const colorValues = {
//     FTextFieldStatus.normal: FColors.grey4,
//     FTextFieldStatus.success: FColors.green6,
//     FTextFieldStatus.error: FColors.red6,
//     FTextFieldStatus.focus: FColors.blue6,
//   };

//   Color get color => colorValues[this];
// }
