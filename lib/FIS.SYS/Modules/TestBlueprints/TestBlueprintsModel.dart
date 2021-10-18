import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsItem.dart';

class TestBlueprintsModel extends BaseResponse {
  List<TestBlueprintsItem> testBlueprintsItem;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['stats'] as List;
      testBlueprintsItem =
          list.map((c) => TestBlueprintsItem.fromJson(c)).toList();
    }
  }
}
