import 'package:Framework/FIS.SYS/Modules/BaseResponse.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileItem.dart';

class FilesModel extends BaseResponse {
  List<FileItem> fileItems;
  @override
  fromJson(Map<String, dynamic> json) {
    statusCode = json["statusCode"];
    message = json["message"];
    fileItems = (json['data']['file_list'] as List)
        .map((e) => FileItem.fromJson(e))
        .toList();
  }
}
