import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import './StatsTestOutlineItem.dart';

class StatsTestOutlineModel extends BaseResponse {
  List<StatsTestOutlineItem> testBlueprintsItems;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['test_blueprints'] as List;
      testBlueprintsItems =
          list.map((c) => StatsTestOutlineItem.fromJson(c)).toList();
    }
  }
}
