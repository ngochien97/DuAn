import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/TakerGroup.dart';

abstract class NotificationChangeEvent {
  const NotificationChangeEvent();
}

class TakerGroupEvent extends NotificationChangeEvent {
  TakerGroup takerGroup;
  TakerGroupEvent(this.takerGroup);
}

class TakerGroupUpdateEvent extends NotificationChangeEvent {
  TakerGroup takerGroup;
  String message;
  String type;
  TakerGroupUpdateEvent(this.takerGroup, {this.message, this.type});
}

class GetHistoryNotificationsEvent extends NotificationChangeEvent {
  String message;
  String type;
  GetHistoryNotificationsEvent({this.message, this.type});
}

class UpdateTakerGroupEvent extends NotificationChangeEvent {
  TakerGroup takerGroup;
  UpdateTakerGroupEvent(this.takerGroup);
}
