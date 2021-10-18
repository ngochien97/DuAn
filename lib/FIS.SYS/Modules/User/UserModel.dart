import '../../Core/BaseResponse.dart';
import 'UserItem.dart';

class UserModel extends BaseResponse {
  UserItem userItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    userItem = UserItem.fromJson(json['data']['user']);
  }
}
