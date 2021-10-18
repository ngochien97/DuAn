import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/StudentReport/StudentReportItem.dart';

class StudentReportModel extends BaseResponse {
  StudentReportItem studentReportItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      studentReportItem = StudentReportItem.fromJson(json['data']);
    }
  }
}
