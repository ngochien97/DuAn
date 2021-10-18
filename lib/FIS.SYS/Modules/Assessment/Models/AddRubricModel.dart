import '../../../Core/BaseResponse.dart';


class AddRubricModel extends BaseResponse {
  int id;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      
      id = (json['data']['id'] as num).toInt() ;
    }
  }
}
