import '../../Core/BaseResponse.dart';
import '../TakerGroups/ClassInfomation.dart';

class ClassPresentModel extends BaseResponse {
  List<ClassInfomation> classes;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['class'] as List;
      classes = list.map((c) => ClassInfomation.fromJson(c)).toList();
    }
  }
}
