import 'dart:io';

import 'package:Framework/FIS.SYS/Modules/BaseDA.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FilesModel.dart';
import 'package:Framework/F.Utils/Convert.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class FileDA extends BaseDA {
  // Future<FilesModel> getAll(String comEmail, String fileName, String sort,
  //     int page, int pageSize) async {
  //   var query = "comEmail=$comEmail";
  //   query += fileName == null ? "" : "&filename=$fileName";
  //   query += sort == null ? "" : "&sort=$sort";
  //   query += "&page=$page";
  //   query += "&pageSize=$pageSize";
  //   var result = await get(
  //       Config.urlFile + "mobile-get-list-file?$query", new FilesModel());
  //   return result;
  // }

  Future<FilesModel> getFiles(
    String page,
    String size,
    String comEmail,
    String filename,
    String sort,
  ) async {
    var result = await get(
      Config.urlFile +
          "mobile-get-list-file?page=$page&pageSize=$size&comEmail=$comEmail&filename=$filename&sort=$sort",
      new FilesModel(),
    );
    return result;
  }

  Future<FilesModel> postFile(
    File file,
    Map<String, String> fields,
    String fileName,
  ) async {
    var uri = Uri.parse("${Config.urlFile}mobile-upload-file");
    var multipartFile = http.MultipartFile(
      "file",
      file.openRead(),
      file.lengthSync(),
      filename: fileName.newUnicodeToAscii().slug() + extension(file.path),
    );
    var result = await postMultipartFiles(
        uri, [multipartFile], fields, new FilesModel());
    return result;
  }

  Future<FilesModel> postFiles(
    List<File> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse("${Config.urlFile}mobile-upload-file");
    var multipartFiles = files
        .map((e) => http.MultipartFile("file", e.openRead(), e.lengthSync()))
        .toList();
    var result =
        await postMultipartFiles(uri, multipartFiles, fields, new FilesModel());
    return result;
  }
}
