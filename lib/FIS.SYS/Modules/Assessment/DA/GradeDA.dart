import 'package:khao_thi_gv/FIS.SYS/Core/BaseDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/GradesItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/GradesModel.dart';

import '../../ConfigKhaoThi.dart';

class GradeDA extends BaseDA {
  Future<GradesModel> getMyGrades() async {
    const url = ConfigAPI.myGrades;

    final data = await CacheService.getAll<GradesItem>();

    if (data != null && data.isNotEmpty) {
      if (data[0].dateCached.isAfter(DateTime.now().add(Duration(days: -7)))) {
        final temp = GradesModel();
        temp.grades = data;
        temp.code = 200;
        return temp;
      }
      await CacheService.clear<GradesItem>();
    }

    final GradesModel result = await get(url, GradesModel());
    if (result.code == 200 && result.grades.isNotEmpty) {
      result.grades.forEach((element) {
        CacheService.add<GradesItem>('${element.id}', element);
      });
    }

    return result;
  }
}
