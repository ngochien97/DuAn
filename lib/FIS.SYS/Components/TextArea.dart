import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FTextArea extends StatefulWidget {
  final String label;
  final String hint;
  final Color backgroundColor;
  final Color labelTextColor;
  final Color inputTextColor;
  final bool hasLabel;
  final bool enabled;

  FTextArea({
    @required this.hint,
    @required this.label,
    this.backgroundColor = FColors.grey1,
    this.labelTextColor = FColors.grey6,
    this.inputTextColor = FColors.grey10,
    this.hasLabel = true,
    this.enabled = true,
  });

  @override
  State<StatefulWidget> createState() {
    return new _FTextAreaState(
      hint: hint,
      label: label,
      backgroundColor: backgroundColor,
      labelTextColor: labelTextColor,
      inputTextColor: inputTextColor,
      hasLabel: hasLabel,
      enabled: enabled,
    );
  }
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

  TextEditingController _fTextAreaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => ,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 68),
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
                            contentPadding: EdgeInsets.all(0),
                          ),
                          onTap: () => activeForcus(),
                          onFieldSubmitted: (text) => validation(),
                        ),
                      )
                    : Container(
                        child: isActive
                            ? Column(
                                children: [
                                  Container(
                                    height: 16,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                    child: FText(
                                      label,
                                      style: FTextStyle.subtitle2,
                                      color: labelTextColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(16, 4, 16, 48),
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
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      onTap: () => activeForcus(),
                                      onFieldSubmitted: (text) => validation(),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(16, 17, 16, 59),
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
                                    contentPadding: EdgeInsets.all(0),
                                  ),
                                  onTap: () => activeForcus(),
                                  onFieldSubmitted: (text) => validation(),
                                ),
                              ),
                      ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: FText(
              message,
              style: FTextStyle.subtitle2,
              color: msgColor,
            ),
          ),
        ],
      ),
    );
  }

  void activeForcus() {
    setState(() {
      isActive = true;
    });
  }

  void validation() {
    if (_fTextAreaController.text.length <= 0) {
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
