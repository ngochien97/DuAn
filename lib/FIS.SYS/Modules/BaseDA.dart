import 'package:Framework/FDA/Models/Auth.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

class BaseDA {
  static String domaniApi = "http://uaa-fda-demo.paas.xplat.fpt.com.vn/";

  // static Future<http.Response> post(
  //     Map<String, dynamic> json, String url, AuthProvider authProvider) async {
  //   return await http.post(domaniApi + url, body: json);

  // http.post(domaniApi + url, body: json).then((response) {
  //   if (response.statusCode == 200) {
  //     var data = convert.jsonDecode(response.body);
  //     authProvider.setAuth(
  //       new Auth(
  //         token: data["data"][0]["token"],
  //         refreshToken: "",
  //         expireDate: DateTime.now().add(Duration(hours: 1)),
  //       ),
  //     );
  //     return response.body;
  //   } else {
  //     print(response.statusCode);
  //   }
  // }).catchError((err) => print(err));
  // }
}
