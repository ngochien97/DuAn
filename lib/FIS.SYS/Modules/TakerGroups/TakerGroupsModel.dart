import '../../Core/BaseResponse.dart';
import 'TakerGroup.dart';

class TakerGroupsModel extends BaseResponse {
  List<TakerGroup> takerGroups;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['test_taker_group'] as List;
      takerGroups = list.map((c) => TakerGroup.fromJson(c)).toList();
      totalCount = json['data']['total_count'];
      pageSize = json['data']['page_size'];
      count = json['data']['count'];
      page = json['data']['page'];
    }
  }
}
