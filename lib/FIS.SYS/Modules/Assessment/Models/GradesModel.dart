import '../../../Core/BaseResponse.dart';
import 'GradesItem.dart';

class GradesModel extends BaseResponse {
  List<GradesItem> grades;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['grades'] as List;
      grades = list.map((c) => GradesItem.fromJson(c)).toList();
    }
  }
}
