import 'package:flutter/material.dart';

import '../Skins/Icon.dart';
import '../Skins/Typography.dart';
import '../Styles/StyleBase.dart';
import 'ComponentsBase.dart';

class FTextFormField extends StatefulWidget {
  final FTextFormFieldSize size;
  final String value;
  final String label;
  final TextInputType keyboardType;
  final bool validate;
  final Function onChanged;
  final Function onTap;
  final Function onEditingComplete;
  final Function onSaved;
  final Function onFieldSubmitted;
  final Function onRightIconPressed;
  final Function validator;
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
  final GlobalKey<FormState> formKey;

  const FTextFormField({
    Key key,
    this.size = FTextFormFieldSize.size32,
    this.value,
    this.label,
    this.keyboardType,
    this.validate,
    this.onChanged,
    this.onFieldSubmitted,
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
    this.onSaved,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.formKey,
  }) : super(key: key);

  @override
  _FTextFormFieldState createState() => _FTextFormFieldState();
}

class _FTextFormFieldState extends State<FTextFormField> {
  // TextEditingController widget.controller = new TextEditingController();
  FTextFormFieldStatus status = FTextFormFieldStatus.normal;
  bool isFocused = false;

  @override
  void initState() {
    widget.controller.text = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(FTextFormField oldWidget) {
    if (widget.validate != oldWidget.validate && oldWidget.validate == false) {
      setState(() {
        status = FTextFormFieldStatus.error;
      });
    } else if (widget.validate != oldWidget.validate &&
        oldWidget.validate == true) {
      setState(() {
        status = FTextFormFieldStatus.normal;
      });
    } else if (widget.validate == oldWidget.validate &&
        oldWidget.validate == true) {
      setState(() {
        status = FTextFormFieldStatus.error;
      });
    } else if (widget.validate != oldWidget.validate &&
        oldWidget.validate == false) {
      setState(() {
        status = FTextFormFieldStatus.normal;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> textFieldState;
    switch (widget.size) {
      case FTextFormFieldSize.size32:
        textFieldState = {
          'size': 30.0,
        };
        break;
      case FTextFormFieldSize.size40:
        textFieldState = {
          'size': 40.0,
        };
        break;
      case FTextFormFieldSize.size56:
        textFieldState = {
          'size': 56.0,
        };
        break;
    }
    return Container(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: status.color),
                color: widget.enabled ? widget.backgroundColor : FColors.grey3,
              ),
              height: textFieldState['size'],
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  widget.leftIcon != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FIcon(
                            icon: widget.leftIcon,
                            size: 16,
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
                        widget.size == FTextFormFieldSize.size56 &&
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
                            setState(
                              () {
                                isFocused = value;
                                if (value &&
                                    status == FTextFormFieldStatus.normal) {
                                  status = FTextFormFieldStatus.focus;
                                } else if (value &&
                                    status == FTextFormFieldStatus.error) {
                                  status = FTextFormFieldStatus.error;
                                } else if (!value &&
                                    status == FTextFormFieldStatus.focus) {
                                  status = FTextFormFieldStatus.normal;
                                } else if (!value &&
                                    status == FTextFormFieldStatus.error) {
                                  status = FTextFormFieldStatus.error;
                                }
                              },
                            );
                          },
                          child: TextFormField(
                            autofocus: widget.autoFocus,
                            controller: widget.controller,
                            validator: widget.validator,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  widget.size == FTextFormFieldSize.size56 &&
                                          isFocused == true
                                      ? null
                                      : widget.label,
                              hintStyle:
                                  FTextStyle.bodyText2.textStyle.copyWith(
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
                              widget.onChanged(value);
                            },
                            onFieldSubmitted: (value) {
                              widget.onFieldSubmitted(value);
                            },
                            onSaved: (value) {
                              widget.onSaved(value);
                            },
                            onTap: () {
                              widget.onTap();
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
                                if (widget.value != null ||
                                    widget.value != '') {
                                  widget.controller.clear();
                                  widget.onChanged(widget.controller.text);
                                  if (!isFocused) {
                                    setState(() {
                                      status = FTextFormFieldStatus.normal;
                                    });
                                  }
                                }
                              }
                            },
                            icon: FFilledIcons.close_circle,
                            size: 16,
                            color: const <Color>[FColors.grey6],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(right: 8),
                        ),
                  widget.clearable == true && widget.rightIcon != null
                      ? const FDivider(
                          vertical: true,
                          height: 12,
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
                            size: 16,
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
                      color: status == FTextFormFieldStatus.normal
                          ? FColors.grey7
                          : status.color,
                      style: FTextStyle.subtitle2,
                      maxLines: 2,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

enum FTextFormFieldSize {
  size32,
  size40,
  size56,
}

enum FTextFormFieldStatus {
  normal,
  success,
  error,
  focus,
}

extension FTextFormFieldStatusExtension on FTextFormFieldStatus {
  static const colorValues = {
    FTextFormFieldStatus.normal: FColors.grey4,
    FTextFormFieldStatus.success: FColors.green6,
    FTextFormFieldStatus.error: FColors.red6,
    FTextFormFieldStatus.focus: FColors.blue6,
  };

  Color get color => colorValues[this];
}