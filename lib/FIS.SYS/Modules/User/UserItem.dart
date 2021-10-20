import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class UserItem extends BaseItem {
  String email;
  String password;
  bool isRemember = false;
  String userId;
  String fullName;
  String phoneNumber;
  String orgId;
  String groupCodes;
  String comEmails;
  String avatarBase64;
  String token;
  String newPassword;
  String newPassword2;
  String avatar;
  String coverImage;
  UserItem({
    this.email,
    this.password,
    this.isRemember,
    this.userId,
    this.fullName,
    this.phoneNumber,
    this.orgId,
    this.groupCodes,
    this.comEmails,
    this.avatarBase64,
    this.newPassword,
    this.newPassword2,
    this.token,
    this.avatar,
    this.coverImage,
  });

  UserItem.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    orgId = json['orgId'];
    groupCodes = json['groupCodes'];
    comEmails = json['comEmails'];
    avatarBase64 = json['avatarBase64'];
    token = json['token'];
  }
}
