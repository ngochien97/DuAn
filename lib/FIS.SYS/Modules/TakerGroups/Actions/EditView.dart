import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../F.Utils/Convert.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../DA/TakerGroupDA.dart';
import '../TakerGroup.dart';

class EditTaker extends StatefulWidget {
  final TakerGroup group;
  final void Function(TakerGroup) callBack;
  const EditTaker(this.group, {this.callBack});
  @override
  _EditTakerState createState() => _EditTakerState();
}

class _EditTakerState extends State<EditTaker> {
  DateTime fromTime = DateTime.now();
  DateTime dueTime = DateTime.now();
  DateTime toTime = DateTime.now();
  int timeLimit = 0;
  bool isLoading = false;
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;
  Future<void> save() async {
    if (isLoading) {
      return;
    }

    //validate datetime
    if (fromTime != widget.group.fromTime) {
      if (fromTime.isBefore(DateTime.now())) {
        showMessage(
            'Thời gian mở kíp phải sau thời điểm hiện tại', SkinColor.error);
        return;
      }
    }

    if (dueTime != widget.group.dueTime) {
      if (dueTime.isBefore(DateTime.now())) {
        showMessage('Hạn rút đề phải sau thời điểm hiện tại', SkinColor.error);
        return;
      }
    }

    // check thoi gian bat dau voi kip thi tu dong
    if (widget.group.controlMode) {
      if (toTime != widget.group.toTime) {
        if (toTime.isBefore(DateTime.now())) {
          showMessage('Thời gian đóng kíp phải sau thời điểm hiện tại',
              SkinColor.error);
          return;
        }
      }

      if (fromTime.isAfter(dueTime)) {
        showMessage('Thời gian hết hạn rút đề phải sau thời gian bắt đầu',
            SkinColor.error);
        return;
      }

      if (dueTime.isAfter(toTime)) {
        showMessage('Thời gian đóng kíp phải sau thời gian hết hạn rút đề',
            SkinColor.error);
        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    final data = await takerGroupDA.udpateTakerGroup(
        widget.group.id, fromTime, dueTime, toTime, timeLimit);
    setState(() {
      isLoading = false;
    });
    showFSnackBar(
        context,
        FSnackBar(
          message: FText(
            '${data.message}',
            color: FColors.grey1,
          ),
          borderRadius: 8.0,
          position: FlushbarPosition.TOP,
          backgroundColor:
              data.code == 200 ? SkinColor.success : SkinColor.error,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ));

    if (data.code == 200) {
      if (widget.callBack != null) {
        widget.callBack(data.takerGroup);
      }
      showMessage('Cập nhật kíp thi thành công', SkinColor.success);
    } else if (data.code == 400) {
      showMessage(data.errors[0], SkinColor.error);
    }
  }

  void showMessage(String message, Color color) {
    showFSnackBar(
        context,
        FSnackBar(
          message: FText(
            '$message',
            color: FColors.grey1,
          ),
          borderRadius: 8.0,
          position: FlushbarPosition.TOP,
          backgroundColor: color,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ));
  }

  @override
  void initState() {
    fromTime = widget.group.fromTime;
    dueTime = widget.group.dueTime;
    toTime = widget.group.toTime;
    timeLimit = widget.group.timeLimit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(top: 32),
      child: FBottomSheet(
        header: FModal(
          title: FText(
            'Sửa kíp thi',
            style: FTextStyle.titleModules3,
          ),
        ),
        body: Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            color: FColors.grey1,
            child: Column(
              children: [
                if (widget.group.controlMode)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: FColors.transparent,
                                isDismissible: false,
                                builder: (context) => FBottomSheet(
                                    header: FModal(
                                      title: Container(),
                                      textAction: FButton(
                                        title: 'Xong',
                                        backgroundColor: FColors.transparent,
                                        color: FColors.blue6,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      iconAction: Container(),
                                    ),
                                    body: Container(
                                      color: FColors.grey1,
                                      child: SizedBox(
                                        height: 200,
                                        child: CupertinoDatePicker(
                                          initialDateTime: fromTime,
                                          onDateTimeChanged: (dateTime) {
                                            setState(() {
                                              fromTime = dateTime;
                                            });
                                          },
                                        ),
                                      ),
                                    )));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: FColors.grey6),
                                  color: FColors.grey1),
                              child: FListTitle(
                                title: FText(
                                  'Ngày giờ bắt đầu',
                                  style: FTextStyle.subtitle2,
                                ),
                                subtitle: FText(
                                    fromTime.format('dd/MM/yyyy, HH:mm'),
                                    style: FTextStyle.subtitle1,
                                    color: FColors.grey9),
                                action: [
                                  FIcon(icon: FOutlinedIcons.down, size: 10)
                                ],
                              )),
                        ),
                      ),
                      FSpacer.hozirontalSpace16px,
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                backgroundColor: FColors.transparent,
                                builder: (context) => FBottomSheet(
                                    header: FModal(
                                      title: Container(),
                                      textAction: FButton(
                                        title: 'Xong',
                                        backgroundColor: FColors.transparent,
                                        color: FColors.blue6,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      iconAction: Container(),
                                    ),
                                    body: Container(
                                      color: FColors.grey1,
                                      child: SizedBox(
                                        height: 200,
                                        child: CupertinoDatePicker(
                                          initialDateTime: dueTime,
                                          onDateTimeChanged: (dateTime) {
                                            setState(() {
                                              dueTime = dateTime;
                                            });
                                          },
                                        ),
                                      ),
                                    )));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: FColors.grey6),
                                  color: FColors.grey1),
                              child: FListTitle(
                                title: FText(
                                  'hạn rút đề',
                                  style: FTextStyle.subtitle2,
                                ),
                                subtitle: FText(
                                  dueTime.format('dd/MM/yyyy, HH:mm'),
                                  style: FTextStyle.subtitle1,
                                  color: FColors.grey9,
                                ),
                                action: [
                                  FIcon(
                                    icon: FOutlinedIcons.down,
                                    size: 10,
                                  )
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        backgroundColor: FColors.transparent,
                        builder: (context) => FBottomSheet(
                            header: FModal(
                              title: Container(),
                              textAction: FButton(
                                title: 'Xong',
                                backgroundColor: FColors.transparent,
                                color: FColors.blue6,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              iconAction: Container(),
                            ),
                            body: Container(
                              color: FColors.grey1,
                              child: SizedBox(
                                height: 200,
                                child: CupertinoDatePicker(
                                  initialDateTime: toTime,
                                  onDateTimeChanged: (dateTime) {
                                    setState(() {
                                      toTime = dateTime;
                                    });
                                  },
                                ),
                              ),
                            )));
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 21),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: FColors.grey6),
                          color: FColors.grey1),
                      child: FListTitle(
                        title: FText(
                          'Giờ đóng kíp thi',
                          style: FTextStyle.subtitle2,
                        ),
                        subtitle: FText(toTime.format('dd/MM/yyyy, HH:mm'),
                            style: FTextStyle.subtitle1, color: FColors.grey9),
                        action: [
                          FIcon(
                            icon: FOutlinedIcons.down,
                            size: 10,
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<int>(
                      context: context,
                      builder: (BuildContext context) =>
                          NumberPickerDialog.integer(
                        cancelWidget: FText(
                          'Thoát',
                          style: FTextStyle.bodyText1,
                          color: FColors.blue6,
                        ),
                        confirmWidget: FText('Đồng ý',
                            style: FTextStyle.bodyText1, color: FColors.blue6),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: FColors.grey7,
                            ),
                            bottom: BorderSide(
                              color: FColors.grey7,
                            ),
                          ),
                        ),
                        minValue: 0,
                        maxValue: 1440,
                        initialIntegerValue: timeLimit,
                      ),
                    ).then((num value) {
                      if (value != null) {
                        setState(() => timeLimit = value);
                      }
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 21),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: FColors.grey6),
                          color: FColors.grey1),
                      child: FListTitle(
                        title: FText(
                          'Thời gian thi (phút)',
                          style: FTextStyle.subtitle2,
                        ),
                        subtitle: FText('$timeLimit',
                            style: FTextStyle.subtitle1, color: FColors.grey9),
                        action: [
                          FIcon(
                            icon: FOutlinedIcons.down,
                            size: 10,
                          )
                        ],
                      )),
                ),
                FSpacer.space16px,
                Container(
                  child: FButton(
                    title: 'Lưu lại',
                    size: FButtonSize.size40,
                    block: true,
                    isLoading: isLoading,
                    onPressed: () async {
                      await save();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}
