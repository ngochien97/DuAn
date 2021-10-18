import '../../Core/BaseResponse.dart';

import 'Stat.dart';
import 'SummaryStat.dart';

class StatModel extends BaseResponse {
  List<Stat> stats;
  SummaryStat summary;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['stats'] as List;
      stats = list.map((c) => Stat.fromJson(c)).toList();
      summary = SummaryStat.fromJson(json['data']['sumary']);
    }
  }
}
