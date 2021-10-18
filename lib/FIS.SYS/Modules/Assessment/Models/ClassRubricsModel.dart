import '../../../Core/BaseResponse.dart';
import 'ClassRubricItem.dart';

class ClassRubricsModel extends BaseResponse {
  List<ClassRubricItem> classes;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['classes'] as List;
      classes = list.map((c) => ClassRubricItem.fromJson(c)).toList();
    }
  }
}
