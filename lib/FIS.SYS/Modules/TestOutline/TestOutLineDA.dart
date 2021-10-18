import 'package:khao_thi_gv/FIS.SYS/Core/BaseDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineModel.dart';
import '../ConfigKhaoThi.dart';

class TestOutLineDA extends BaseDA {
  Future<TestOutLineModel> getInfo() async {
    const url = ConfigAPI.getSearch;
    final result = await get(url, TestOutLineModel());
    return result;
  }
}
