import '../../Core/BaseResponse.dart';
import 'TakerGroupSummary.dart';
import 'TestTaker.dart';

class TakerGroupSummaryModel extends BaseResponse {
  TakerGroupSummary takerGroupSummary;
  List<TestTaker> testTakers;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      takerGroupSummary =
          TakerGroupSummary.fromJson(json['data']['stats_summary']);
      if (json['data']['test_taker'] != null) {
        testTakers = (json['data']['test_taker'] as List)
            .map((e) => TestTaker.fromJson(e))
            .toList();
      }
    }
  }
}
