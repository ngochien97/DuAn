import 'package:khao_thi_gv/FIS.SYS/Core/BaseDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/AddRubricModel.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricsModel.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/RubricInClassModel.dart';

import '../../ConfigKhaoThi.dart';

class ClassRubricDA extends BaseDA {
  Future<ClassRubricsModel> getAssessmentMyClasses() async {
    const url = ConfigAPI.assessmentMyClasses;
    final result = await get(url, ClassRubricsModel());

    return result;
  }

  Future<RubricInClassModel> searchRubric(String txt) async {
    const url = ConfigAPI.searchRubric;
    final result = await get('$url?keyword=$txt', RubricInClassModel());

    return result;
  }

  Future<AddRubricModel> addRubric(int classId, int rubricId) async {
    const url = ConfigAPI.appendRubric;
    final result = await post(
        '$url?class_id=$classId&rubric_id=$rubricId', AddRubricModel());

    return result;
  }

  Future<BasicResponse> removeRubric(int classRubricId) async {
    const url = ConfigAPI.removeRubric;
    final result =
        await delete('$url?class_rubric_id=$classRubricId', BasicResponse());

    return result;
  }
}
