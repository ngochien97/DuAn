abstract class BaseResponse {
  void fromJson(Map<String, dynamic> json);

  String message;
  int code;
  int totalCount;
  int pageSize;
  int count;
  int page;
  List<String> errors = [];
  DateTime dateCached;
}

class BasicResponse extends BaseResponse {
  int id;
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
