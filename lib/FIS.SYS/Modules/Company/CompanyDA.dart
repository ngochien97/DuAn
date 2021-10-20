import 'package:Framework/FIS.SYS/Modules/BaseDA.dart';
import 'package:Framework/FIS.SYS/Modules/Company/ModelCompanyItem.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';

class CompanyDA extends BaseDA {
  Future<ModelCompanyItem> getCompanyData() async {
    var result = await get(
      Config.domaniApi + "mobile-get-list-company",
      new ModelCompanyItem(),
    );
    return result;
  }
}
