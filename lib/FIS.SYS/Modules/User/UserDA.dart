import '../../Core/BaseDA.dart';
import '../ConfigKhaoThi.dart';
import '../Unit/CompanyModel.dart';
import 'UserModel.dart';

class UserDA extends BaseDA {
  Future<UserModel> getInfo() async {
    const url = ConfigAPI.userInfo;
    final result = await get(url, UserModel());
    return result;
  }

  Future<CompanyModel> getCompanyInfo() async {
    const url = ConfigAPI.companyInfo;
    final result = await get(url, CompanyModel());
    return result;
  }
}
