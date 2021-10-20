import 'package:Framework/FIS.SYS/Modules/BaseResponse.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyItem.dart';

class ModelCompanyItem extends BaseResponse {
  var listComItem = new List<CompanyItem>();
  @override
  fromJson(Map<String, dynamic> json) {
    statusCode = json["statusCode"];
    message = json["message"];
    for (var item in json['data'][0]["comList"]) {
      listComItem.add(CompanyItem.fromJson(item));
    }
  }
}
