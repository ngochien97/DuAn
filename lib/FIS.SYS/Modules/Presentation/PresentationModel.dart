import '../../Core/BaseResponse.dart';
import 'PresentationItem.dart';

class PresentationModel extends BaseResponse {
  List<PresentationItem> presents;
  PresentationItem present;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final jsonList = json['data']['presentations'];
      if (jsonList != null) {
        final list = jsonList as List;
        presents = list.map((c) => PresentationItem.fromJson(c)).toList();
      }

      final jsonPresent = json['data']['presentation'];
      if (jsonPresent != null) {
        present = PresentationItem.fromJson(jsonPresent);
      }
    }
  }
}
