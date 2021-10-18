import '../../Core/BaseResponse.dart';
import 'StudentAnswerItem.dart';
import 'StudentItem.dart';
import 'TestFormItem.dart';

class StudentModel extends BaseResponse {
  StudentItem studentItem;
  List<StudentAnswerItem> listStudentAnswerItem;
  List<StudentAnswerItem> listChildrenItem;
  TestFormItem testFormItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      studentItem = StudentItem.fromJson(json['data']['test_taker']);
      if (json['data']['items'] != null || json['data']['items'] != []) {
        listStudentAnswerItem = (json['data']['items'] as List)
            .map((e) => StudentAnswerItem.fromJson(e))
            .toList();
      }
      if (json['data']['items_children'] != null ||
          json['data']['items_children'] != []) {
        listChildrenItem = (json['data']['items_children'] as List)
            .map((e) => StudentAnswerItem.fromJson(e))
            .toList();
      }
      testFormItem = TestFormItem.fromJson(json['data']['test_form']);
    }
  }
}
