import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestOutline/TestOutLineItem.dart';

class TestOutLineModel extends BaseResponse {
  TestOutlineItem testOutlineItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    testOutlineItem = TestOutlineItem.fromJson(json['data']);
  }
}
