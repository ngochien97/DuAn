import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/Unit/CompanyItem.dart';
import '../../FIS.SYS/Modules/User/UserDA.dart';
import '../../FIS.SYS/Skins/Icon.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';

class UnitInforScreen extends StatefulWidget {
  @override
  _UnitInforScreenState createState() => _UnitInforScreenState();
}

class _UnitInforScreenState extends State<UnitInforScreen> {
  CompanyItem companyItem = CompanyItem();
  UserDA userDA = UserDA();
  List<Map<String, dynamic>> listInfor = [];

  @override
  void initState() {
    userDA.getCompanyInfo().then((value) {
      setState(() {
        companyItem = value.companyItem;
        listInfor = [
          {
            'title': 'Tên đơn vị',
            'content': companyItem.name,
            'icon': null,
            'onPressed': () {}
          },
          {
            'title': 'Mã đơn vị',
            'content': companyItem.code,
            'icon': null,
            'onPressed': null
          },
          {
            'title': 'Địa chỉ',
            'content': companyItem.address,
            'icon': null,
            'onPressed': () {}
          },
          {
            'title': 'Tên người liên hệ',
            'content': companyItem.contactName,
            'icon': null,
            'onPressed': null
          },
          {
            'title': 'Số điện thoại',
            'content': companyItem.phone,
            'icon': FFilledIcons.copy,
            'onPressed': () {
              if (companyItem.phone != null && companyItem.phone != '') {
                showFSnackBar(
                  context,
                  FSnackBar(
                    message: FText(
                      'đã sao chép',
                      color: FColors.grey1,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: FColors.grey7,
                    borderRadius: 12.0,
                    icon: FIcon(
                      icon: FFilledIcons.check_circle,
                      color: const <Color>[FColors.grey1, FColors.transparent],
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.25,
                        vertical: 8.0),
                  ),
                );
                FlutterClipboard.copy(companyItem.adminEmail);
              }
            }
          },
          {
            'title': 'Email',
            'content': companyItem.adminEmail,
            'icon': FFilledIcons.copy,
            'onPressed': () {
              if (companyItem.adminEmail != null &&
                  companyItem.adminEmail != '') {
                showFSnackBar(
                  context,
                  FSnackBar(
                    message: FText(
                      'đã sao chép',
                      color: FColors.grey1,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: FColors.grey7,
                    borderRadius: 12.0,
                    icon: FIcon(
                      icon: FFilledIcons.check_circle,
                      color: const <Color>[FColors.grey1, FColors.transparent],
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.25,
                        vertical: 8.0),
                  ),
                );
                FlutterClipboard.copy(companyItem.adminEmail);
              }
            }
          }
        ];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: FAppBar(
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            color: FColors.grey10,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Thông tin đơn vị',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerActions: [
            Container(
              width: 48,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              for (var element in listInfor)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: FColors.grey4),
                  ),
                  child: FListTitle(
                    title: FText(
                      element['title'],
                      style: FTextStyle.subtitle2,
                    ),
                    subtitle: FText(
                      element['content'],
                      style: FTextStyle.titleModules5,
                    ),
                    action: [
                      element['icon'] != null
                          ? FIconButton(
                              icon: element['icon'],
                              color: FColors.grey7,
                              backgroundColor: FColors.transparent,
                              onPressed: element['onPressed'],
                            )
                          : Container(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
}
