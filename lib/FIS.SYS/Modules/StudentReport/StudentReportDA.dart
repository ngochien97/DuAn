import 'package:khao_thi_gv/FIS.SYS/Core/BaseDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportModel.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/StatsTestOutline/StatsTestOutlineModel.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsModel.dart';
import '../ConfigKhaoThi.dart';

class StudentReportDA extends BaseDA {
  Future<StudentReportModel> getTableStudentReport(int id, int test_outline_id,
      String filter_to_date, String filter_from_date) async {
    var url = '${ConfigAPI.getTableStudentReport}?student_id=$id';
    if (test_outline_id > 0) {
      url += '&filter[test_outline_id]=$test_outline_id';
    }
    if (filter_from_date != null) {
      url += '&filter[filter_from_date]=$filter_from_date';
      url += '&filter[filter_time]=submitted_at';
    }
    if (filter_to_date != null) {
      url += '&filter[filter_to_date]=$filter_to_date';
      url += '&filter[filter_time]=submitted_at';
    }

    final result = await get(url, StudentReportModel());
    return result;
  }

  Future<TestBlueprintsModel> getStatsTestBlueprint(int id, int test_outline_id,
      String filter_to_date, String filter_from_date) async {
    var url = '${ConfigAPI.statsTestBlueprint}?student_id=$id';
    if (test_outline_id > 0) {
      url += '&filter[test_outline_id]=$test_outline_id';
    }
    if (filter_from_date != null) {
      url += '&filter[filter_from_date]=$filter_from_date';
      url += '&filter[filter_time]=submitted_at';
    }
    if (filter_to_date != null) {
      url += '&filter[filter_to_date]=$filter_to_date';
      url += '&filter[filter_time]=submitted_at';
    }

    final result = await get(url, TestBlueprintsModel());
    return result;
  }

  Future<StatsTestOutlineModel> getStatsTestOutline(int studentId,
      int testOutlineId, int rowNumber, int filterByLevel) async {
    var url = '${ConfigAPI.statsTestOutline}?student_id=$studentId';
    if (testOutlineId > 0) {
      url += '&test_outline_id=$testOutlineId';
    }
    if (rowNumber > 0) {
      url += '&row_number=$rowNumber';
    }
    if (filterByLevel > 0) {
      url += '&filter_by_level=$filterByLevel';
    }

    final result = await get(url, StatsTestOutlineModel());
    return result;
  }
}
