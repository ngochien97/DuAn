import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ListTileNew.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/TakerGroup.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationState.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';
import 'package:khao_thi_gv/locator.dart';

class ListNotifications extends StatefulWidget {
  ListNotifications({Key key}) : super(key: key);

  @override
  _ListNotificationsState createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  @override
  void initState() {
    super.initState();
    getHistory();
  }

  Future<void> getHistory() async {
    locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HistoryNotificationsState) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ...buildHistories(state.histories),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }

  List<Widget> buildHistories(List<HistoryNotificationItem> lst) {
    final lstWidget = <Widget>[];
    lst.forEach((history) {
      lstWidget.add(FListTileNew(
        size: FListTileSize.size88,
        title: FText(
          '${history.message}',
          style: FTextStyle.bodyText1,
          fontWeight: history.status == 0 ? FontWeight.w600 : FontWeight.normal,
        ),
        subtitle: FText(
          '${getTime(history.dateCreated)}',
          fontWeight: history.status == 0 ? FontWeight.w600 : FontWeight.normal,
        ),
        onTap: () {
          showHistory(history);
        },
      ));
      lstWidget.add(FDivider(
        indent: 16,
      ));
    });
    return lstWidget;
  }

  String getTime(DateTime dateCreated) {
    final dateTimeNow = DateTime.now();
    final differenceInDays = dateTimeNow.difference(dateCreated).inMinutes;
    if (differenceInDays < 60) {
      return '$differenceInDays phút trước';
    }
    final hour = dateTimeNow.difference(dateCreated).inHours;
    if (hour < 24) {
      return '$hour giờ trước';
    }
    final day = dateTimeNow.difference(dateCreated).inDays;
    if (day < 365) {
      return '$hour ngày trước';
    }
    return '';
  }

  Future<void> showHistory(HistoryNotificationItem history) async {
    if (history.type == 'update_test_taker_group') {
      final data = json.decode(history.objectData);
      final takerGroup = TakerGroup.fromJson(data);
      final dataCache =
          await CacheService.getByKey<HistoryNotificationItem>(history.id);
      dataCache.status = 1;
      await CacheService.add<HistoryNotificationItem>(history.id, dataCache);
      await CoreRoutes.instance
          .navigateTo(RouteNames.TAKERGROUPDETAIL, arguments: takerGroup);
      locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
    }
  }
}
