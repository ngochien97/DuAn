import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class CompanyItem extends BaseItem {
  String companyId;
  String companyName;
  String taxNum;
  String email;
  String comEmails;
  int type;
  String address;
  String telephone;
  int numFileWait;
  int numFileDone;
  int numFileFail;
  int numFileDelete;
  String avatarBase64;

  CompanyItem({
    this.companyId,
    this.companyName,
    this.taxNum,
    this.email,
    this.comEmails,
    this.type,
    this.address,
    this.telephone,
    this.numFileWait,
    this.numFileDone,
    this.numFileFail,
    this.numFileDelete,
    this.avatarBase64,
  });

  CompanyItem.fromJson(Map<String, dynamic> json) {
    companyId = json["companyId"];
    companyName = json["companyName"];
    taxNum = json["taxNum"];
    email = json["email"];
    comEmails = json["comEmails"];
    type = json["type"];
    address = json["address"];
    telephone = json["telephone"];
    numFileWait = json["numFileWait"];
    numFileDone = json["numFileDone"];
    numFileFail = json["numFileFail"];
    numFileDelete = json["numFileDelete"];
    avatarBase64 = json["avatarBase64"];
  }
}
