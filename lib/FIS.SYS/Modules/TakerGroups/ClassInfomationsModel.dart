import '../../Core/BaseResponse.dart';

import 'ClassInfomation.dart';

class ClassInfomationsModel extends BaseResponse {
  List<ClassInfomation> classes;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['classes'] as List;
      classes = list.map((c) => ClassInfomation.fromJson(c)).toList();
    }
  }
}
