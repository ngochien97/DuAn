import '../../../Core/BaseDA.dart';

import '../../ConfigKhaoThi.dart';
import '../ClassInfomationsModel.dart';

class ClassDA extends BaseDA {
  Future<ClassInfomationsModel> getInfo() async {
    const url = ConfigAPI.getTestTakerClassInfomation;
    final result = await get(url, ClassInfomationsModel());
    return result;
  }
}
