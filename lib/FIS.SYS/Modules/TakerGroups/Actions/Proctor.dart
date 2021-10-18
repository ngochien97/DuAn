import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';

class Proctor extends StatefulWidget {
  final String proctor;
  final String proctor2;
  const Proctor(this.proctor, this.proctor2);
  @override
  _ProctorState createState() => _ProctorState();
}

class _ProctorState extends State<Proctor> {
  bool _canShowCode1 = true;
  bool _canShowCode2 = true;
  @override
  Widget build(BuildContext context) => Container(
          child: FBottomSheet(
        header: FModal(
          title: FText(
            'Mã giám thị',
            style: FTextStyle.titleModules3,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: FColors.grey1,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: FColors.grey6),
                      color: FColors.grey1),
                  child: FListTitle(
                    title: FText(
                      'Mã giám thị 1',
                      style: FTextStyle.bodyText1,
                    ),
                    subtitle: Row(
                      children: [
                        FText(
                          _canShowCode1
                              ? '${widget.proctor}'
                                  .replaceAll(RegExp(r'[A-Za-z0-9]'), '*')
                              : '${widget.proctor}',
                        ),
                        GestureDetector(
                          onTap: () {
                            FlutterClipboard.copy('${widget.proctor}');
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    'Đã sao chép',
                                    color: FColors.grey1,
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: FColors.grey9,
                                  borderRadius: 8.0,
                                  icon: FIcon(
                                    icon: FOutlinedIcons.check_circle,
                                    color: const <Color>[FColors.grey1],
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 8.0),
                                ));
                          },
                          child: FText(' SAO CHÉP MÃ', color: FColors.blue6),
                        )
                      ],
                    ),
                    action: [
                      FIconButton(
                        backgroundColor: FColors.transparent,
                        color: FColors.grey6,
                        icon: _canShowCode1
                            ? FFilledIcons.eye_invisible
                            : FFilledIcons.eye,
                        size: FIconButtonSize.size48,
                        onPressed: () {
                          setState(() => _canShowCode1 = !_canShowCode1);
                        },
                      )
                    ],
                  )),
              FSpacer.space16px,
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: FColors.grey6),
                    color: FColors.grey1),
                child: FListTitle(
                  title: FText(
                    'Mã giám thị 2',
                    style: FTextStyle.bodyText1,
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      FText(
                        _canShowCode2
                            ? '${widget.proctor2}'
                                .replaceAll(RegExp(r'[A-Za-z0-9]'), '*')
                            : '${widget.proctor2}',
                      ),
                      GestureDetector(
                        onTap: () {
                          FlutterClipboard.copy('${widget.proctor2}');
                          showFSnackBar(
                              context,
                              FSnackBar(
                                message: FText(
                                  'Đã sao chép',
                                  color: FColors.grey1,
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: FColors.grey9,
                                borderRadius: 8.0,
                                icon: FIcon(
                                  icon: FOutlinedIcons.check_circle,
                                  color: const <Color>[FColors.grey1],
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 8.0),
                              ));
                        },
                        child: FText(' SAO CHÉP MÃ', color: FColors.blue6),
                      ),
                    ],
                  ),
                  action: [
                    FIconButton(
                      backgroundColor: FColors.transparent,
                      color: FColors.grey6,
                      icon: _canShowCode2
                          ? FFilledIcons.eye_invisible
                          : FFilledIcons.eye,
                      size: FIconButtonSize.size48,
                      onPressed: () {
                        setState(() => _canShowCode2 = !_canShowCode2);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}
