import 'package:flutter/material.dart';

import '../../F.Utils/SrceenExtensions.dart';
import '../Skins/Typography.dart';
import '../Styles/Colors.dart';
import 'ComponentsBase.dart';

class FTextArea extends StatefulWidget {
  final String label;
  final String hint;
  final Color backgroundColor;
  final Color labelTextColor;
  final Color inputTextColor;
  final bool hasLabel;
  final bool enabled;

  const FTextArea({
    @required this.hint,
    @required this.label,
    this.backgroundColor = FColors.grey1,
    this.labelTextColor = FColors.grey6,
    this.inputTextColor = FColors.grey10,
    this.hasLabel = true,
    this.enabled = true,
  });

  @override
  State<StatefulWidget> createState() => _FTextAreaState(
        hint: hint,
        label: label,
        backgroundColor: backgroundColor,
        labelTextColor: labelTextColor,
        inputTextColor: inputTextColor,
        hasLabel: hasLabel,
        enabled: enabled,
      );
}

class _FTextAreaState extends State<FTextArea> {
  final String label;
  final String hint;
  final Color backgroundColor;
  final Color labelTextColor;
  final Color inputTextColor;
  final bool hasLabel;
  final bool enabled;

  _FTextAreaState({
    @required this.hint,
    @required this.label,
    @required this.backgroundColor,
    @required this.labelTextColor,
    @required this.inputTextColor,
    @required this.hasLabel,
    @required this.enabled,
  });

  bool isActive = false;
  String message = '';
  Color msgColor = FColors.green6;

  final TextEditingController _fTextAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) => GestureDetector(
        // onTap: () => ,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  color: message != ''
                      ? msgColor
                      : isActive ? FColors.blue6 : FColors.grey6,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  !hasLabel
                      ? Container(
                          margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 68.h),
                          child: TextFormField(
                            style: FTextStyle.bodyText2.textStyle
                                .copyWith(color: inputTextColor),
                            controller: _fTextAreaController,
                            enabled: enabled,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: !hasLabel
                                  ? 'Input'
                                  : isActive ? 'Input' : 'Label',
                              hintStyle: FTextStyle.bodyText2.textStyle
                                  .copyWith(color: inputTextColor),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                            onTap: activeForcus,
                            onFieldSubmitted: (text) => validation(),
                          ),
                        )
                      : Container(
                          child: isActive
                              ? Column(
                                  children: [
                                    Container(
                                      height: 16.h,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(
                                          16.w, 8.h, 16.w, 0),
                                      child: FText(
                                        label,
                                        style: FTextStyle.subtitle2,
                                        color: labelTextColor,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          16.w, 4.h, 16.w, 48.h),
                                      child: TextFormField(
                                        style: FTextStyle.bodyText2.textStyle
                                            .copyWith(color: inputTextColor),
                                        controller: _fTextAreaController,
                                        enabled: enabled,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: !hasLabel
                                              ? 'Input'
                                              : isActive ? 'Input' : 'Label',
                                          hintStyle: FTextStyle
                                              .bodyText2.textStyle
                                              .copyWith(color: inputTextColor),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                        ),
                                        onTap: activeForcus,
                                        onFieldSubmitted: (text) =>
                                            validation(),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.w, 17.h, 16.w, 59.h),
                                  child: TextFormField(
                                    style: FTextStyle.bodyText2.textStyle
                                        .copyWith(color: inputTextColor),
                                    controller: _fTextAreaController,
                                    enabled: enabled,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: !hasLabel
                                          ? 'Input'
                                          : isActive ? 'Input' : 'Label',
                                      hintStyle: FTextStyle.bodyText2.textStyle
                                          .copyWith(color: inputTextColor),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(0),
                                    ),
                                    onTap: activeForcus,
                                    onFieldSubmitted: (text) => validation(),
                                  ),
                                ),
                        ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(16.w, 4, 16.w, 0),
              child: FText(
                message,
                style: FTextStyle.subtitle2,
                color: msgColor,
              ),
            ),
          ],
        ),
      );

  void activeForcus() {
    setState(() {
      isActive = true;
    });
  }

  void validation() {
    if (_fTextAreaController.text.isEmpty) {
      setState(() {
        message = 'Sub message line up to 2 line';
        msgColor = FColors.red6;
      });
    } else {
      message = 'Sub message line up to 2 line';
      msgColor = FColors.green6;
    }
  }
}
