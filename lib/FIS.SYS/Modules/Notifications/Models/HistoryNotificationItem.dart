import 'package:hive/hive.dart';
import 'package:khao_thi_gv/F.Utils/GUIDGen.dart';
part 'HistoryNotificationItem.g.dart';

@HiveType(typeId: 2)
class HistoryNotificationItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String objectId;
  @HiveField(2)
  String type;
  @HiveField(3)
  String message;
  @HiveField(4)
  int status;
  @HiveField(5)
  DateTime dateCreated;
  @HiveField(6)
  String objectData;

  HistoryNotificationItem(this.objectId, this.type, this.message,
      {this.objectData}) {
    id = GUIDGen.generate();
    dateCreated = DateTime.now();
    status = 0;
  }
}
