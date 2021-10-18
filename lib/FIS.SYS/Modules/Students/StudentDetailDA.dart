import 'package:khao_thi_gv/F.Utils/Utils.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';

import '../../Core/BaseDA.dart';
import '../ConfigKhaoThi.dart';
import 'StudentModel.dart';

import 'StudentsModel.dart';

class StudentDetailDA extends BaseDA {
  Future<StudentModel> getStudentDetail(int id) async {
    final url = '${ConfigAPI.getTestTakerResult}${'$id'}';
    final result = await get(url, StudentModel());
    return result;
  }

  Future<StudentsModel> getStudentInClass(int classId) async {
    final url = '${ConfigAPI.getStudentInClass}${'$classId'}';
    final result = await get(url, StudentsModel());
    return result;
  }

  Future<StudentsModel> getStudentInClassFromCache(int classId) async {
    try {
      final url = '${ConfigAPI.getStudentInClass}${'$classId'}';

      final students = await CacheService.getByKey<StudentsModel>(classId);
      if (students != null && students.code != null) {
        return students;
      }

      final result = await get(url, StudentsModel());
      if (result.code == 200) {
        await CacheService.add<StudentsModel>(classId, result);
      }

      return result;
    } catch (e) {
      Utils.console(e);
    }
    return StudentsModel()..code = 200;
  }
}
