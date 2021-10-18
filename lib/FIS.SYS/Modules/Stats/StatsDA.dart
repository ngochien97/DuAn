import 'package:khao_thi_gv/FIS.SYS/Core/BaseDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Stats/StatsModel.dart';
import '../ConfigKhaoThi.dart';

class StatsDA extends BaseDA {
  Future<StatsModel> getTablePerforman(int id, int test_outline_id) async {
    var url = '${ConfigAPI.getTableStats}?student_id=$id';
    if (test_outline_id > 0) {
      url += '&test_outline_id=$test_outline_id';
    }
    final result = await get(url, StatsModel());
    return result;
  }
}
