import 'package:hive/hive.dart';
part 'GradesItem.g.dart';

@HiveType(typeId: 3)
class GradesItem {
  @HiveField(0)
  int id;
  @HiveField(1)
  String type;
  @HiveField(2)
  String key;
  @HiveField(3)
  String value;
  bool selected = false;
  @HiveField(4)
  DateTime dateCached = DateTime.now();

  GradesItem({this.id, this.type, this.key, this.value});

  GradesItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    key = json['key'];
    value = json['value'];
  }
}

class ClassRubrics {
  int id;
  String rubricCode;

  ClassRubrics({this.id, this.rubricCode});

  ClassRubrics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rubricCode = json['rubric_code'];
  }
}
