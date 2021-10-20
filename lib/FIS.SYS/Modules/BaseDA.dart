import 'dart:convert';
import 'dart:typed_data';
import 'package:Framework/F.Utils/Convert.dart';
import 'package:Framework/FIS.SYS/Modules/BaseResponse.dart';
import 'package:Framework/FIS.SYS/Modules/Utils/NavigationService.dart';
import 'package:Framework/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BaseDA {
  static final storage = new FlutterSecureStorage();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<BaseResponse> get(String url, BaseResponse baseResponse) async {
    final authenAccessToken = await storage.read(key: "token");
    Map<String, String> headers = {"token": "${authenAccessToken ?? ""}"};
    var datenow = DateTime.now();
    final response = await http.get(url, headers: headers);
    baseResponse.statusCode = response.statusCode;
    var time = DateTime.now().difference(datenow);

    if (time.inSeconds > 1) {
      log(url, "API tối ưu", time.inSeconds, response.statusCode);
    }
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      baseResponse.fromJson(jsondata);
      baseResponse.statusCode = 200;
      return baseResponse;
    } else {
      log(url, "Lỗi định dạng", 0, response.statusCode);
      if (response.statusCode == 401 || response.statusCode == 400) {
        locator<NavigationService>().navigateTo('login_screen');
      }
    }
    return baseResponse;
  }

  Future<BaseResponse> postData(
      String url, dynamic obj, BaseResponse baseResponse) async {
    final authenAccessToken = await storage.read(key: "token");

    Map<String, String> headers = {"token": "${authenAccessToken ?? ""}"};
    final response = await http.post(url, body: obj, headers: headers);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      baseResponse.fromJson(jsondata);
      baseResponse.statusCode = 200;
      return baseResponse;
    } else if (response.statusCode == 401) {
      log(url, "Lỗi định dạng", 0, response.statusCode);
      locator<NavigationService>().navigateTo('login_screen');
    }
    baseResponse.statusCode = response.statusCode;
    return baseResponse;
  }

  Future<Uint8List> getFile(String url) async {
    final authenAccessToken = await storage.read(key: "token");

    Map<String, String> headers = {"token": "${authenAccessToken ?? ""}"};
    final response = await http.get(url, headers: headers);
    return response.bodyBytes;
  }

  Future<BaseResponse> postMultipartFiles(
    Uri uri,
    List<http.MultipartFile> multipartFiles,
    Map<String, String> fields,
    BaseResponse baseResponse,
  ) async {
    final authenAccessToken = await storage.read(key: "token");
    Map<String, String> headers = {"token": "${authenAccessToken ?? ""}"};

    var request = new http.MultipartRequest("POST", uri)
      ..headers.addAll(headers)
      ..fields.addAll(fields)
      ..files.addAll(multipartFiles);

    final response = await request.send();
    baseResponse.statusCode = response.statusCode;
    return baseResponse;
  }

  void log(String url, message, time, status) async {
    url = url.replaceAll('/', '-').replaceAll('?', '-').replaceAll('&', '-');
    var urllog = "http://124.158.4.89:5000/logapp/1/" +
        status.toString() +
        "/SystemApp_Mobile/" +
        url +
        "/FDA/" +
        time.toString() +
        "/" +
        message;
    await http.get(urllog);
  }
}
