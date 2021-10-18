import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Stats/StatsItem.dart';

class StatsModel extends BaseResponse {
  StatsItem statsItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    statsItem = StatsItem.fromJson(json['data']);
  }
}
