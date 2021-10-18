import '../../../Core/BaseResponse.dart';

import 'ClassRubricsItem.dart';

class RubricInClassModel extends BaseResponse {
  List<ClassRubricsItem> rubrics;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['rubrics'] as List;
      rubrics = list.map((c) => ClassRubricsItem.fromJson(c)).toList();
    }
  }
}
