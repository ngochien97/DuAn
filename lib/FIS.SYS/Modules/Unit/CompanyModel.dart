import '../../Core/BaseResponse.dart';
import 'CompanyItem.dart';

class CompanyModel extends BaseResponse {
  CompanyItem companyItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    companyItem = CompanyItem.fromJson(json['data']['company']);
  }
}
