import '../../Core/BaseResponse.dart';
import 'TakerGroup.dart';

class TakerGroupModel extends BaseResponse {
  TakerGroup takerGroup;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];

    if (code == 200) {
      takerGroup = TakerGroup.fromJson(json['data']);
      totalCount = json['data']['total_count'];
      pageSize = json['data']['page_size'];
      count = json['data']['count'];
      page = json['data']['page'];
    } else {
      if (json['errors_array'] != null) {
        errors = List<String>.from(json['errors_array'] as List);
      }
    }
  }
}
