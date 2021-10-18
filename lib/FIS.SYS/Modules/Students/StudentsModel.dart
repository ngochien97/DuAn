import 'package:hive/hive.dart';

import '../../Core/BaseResponse.dart';
import 'StudentItem.dart';
part 'StudentsModel.g.dart';

@HiveType(typeId: 1)
class StudentsModel extends BaseResponse {
  @HiveField(0)
  List<StudentItem> students;

  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      students = (json['data']['student'] as List)
          .map((e) => StudentItem.fromJson(e))
          .toList();
    }
  }
}
