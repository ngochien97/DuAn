import '../../Core/BaseResponse.dart';

import 'TestTaker.dart';

class TestTakersModel extends BaseResponse {
  List<TestTaker> testTakers;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['test_taker'] as List;
      testTakers = list.map((c) => TestTaker.fromJson(c)).toList();
      totalCount = json['data']['total_count'];
      pageSize = json['data']['page_size'];
      count = json['data']['count'];
      page = json['data']['page'];
    }
  }
}
