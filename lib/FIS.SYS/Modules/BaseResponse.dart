abstract class BaseResponse {
  fromJson(Map<String, dynamic> json);

  String message;
  int statusCode;
  int totalCount;
  int pageSize;
  int count;
  int page;
}
