import 'package:Framework/FIS.SYS/Modules/BaseResponse.dart';

import 'UserItem.dart';

class UsersModel extends BaseResponse {
  UserItem userItem;
  @override
  fromJson(Map<String, dynamic> json) {
    statusCode = json["statusCode"];
    message = json["message"];
    userItem = (json['data'] as List).map((e) => UserItem.fromJson(e)).first;
  }
}

class UsersUpdateModel extends BaseResponse {
  @override
  fromJson(Map<String, dynamic> json) {
    statusCode = json["statusCode"];
    message = json["message"];
  }
}

class UsersCreateModel extends BaseResponse {
  @override
  fromJson(Map<String, dynamic> json) {
    message = json["message"];
  }
}
