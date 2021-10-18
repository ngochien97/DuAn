import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';

import 'NotificationEvent.dart';
import 'NotificationState.dart';

class NotificationBloc
    extends Bloc<NotificationChangeEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
      NotificationChangeEvent event) async* {
    if (event is TakerGroupUpdateEvent) {
      yield TakerGroupState(event.takerGroup,
          message: event.message, type: event.type);
    }
    if (event is GetHistoryNotificationsEvent) {
      final histories = await CacheService.getAll<HistoryNotificationItem>();

      histories.sort((a, b) => a.dateCreated.isAfter(b.dateCreated) ? 0 : 1);

      yield HistoryNotificationsState(histories);
    }
  }
}
