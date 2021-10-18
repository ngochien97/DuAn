import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/AppBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Actions/listNotification.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

import '../../locator.dart';

class HistoryNotifications extends StatefulWidget {
  HistoryNotifications({Key key}) : super(key: key);

  @override
  _HistoryNotificationsState createState() => _HistoryNotificationsState();
}

class _HistoryNotificationsState extends State<HistoryNotifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: FAppBar(
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            backgroundColor: FColors.transparent,
            color: FColors.grey9,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Thông báo',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerActions: [
            FIconButton(
              icon: FOutlinedIcons.check,
              backgroundColor: FColors.transparent,
              color: FColors.grey9,
              size: FIconButtonSize.size48,
              onPressed: () async {
                await markRead();
              },
            ),
          ],
        ),
        body: Container(
          child: ListNotifications(),
        ),
      ),
    );
  }

  Future markRead() async {
    var lst = await CacheService.getAll<HistoryNotificationItem>();
    lst.forEach((element) async {
      element.status = 1;
      await CacheService.add<HistoryNotificationItem>(element.id, element);
    });

    locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
  }
}
