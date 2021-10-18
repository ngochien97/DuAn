import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/TakerGroup.dart';

abstract class NotificationState {
  NotificationState();
}

class NotificationInitial extends NotificationState {}

class TakerGroupState extends NotificationState {
  TakerGroup takerGroup;
  String type;
  String message;
  TakerGroupState(this.takerGroup, {this.message, this.type}) : super();
}

class HistoryNotificationsState extends NotificationState {
  List<HistoryNotificationItem> histories;
  HistoryNotificationsState(this.histories) : super();
}
