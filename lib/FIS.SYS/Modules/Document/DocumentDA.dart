export '../BaseDA.dart';

import 'dart:io';

import 'package:Framework/FDA/Models/Document.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FDA/Providers/DocumentProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import '../BaseDA.dart';

class DocumentDA extends BaseDA {
  static Future<void> getDocument(BuildContext context, String comEmail,
      String pages, String sizes, String sort) async {
    String url =
        "http://service-invoice-fda-demo.paas.xplat.fpt.com.vn/mobile-get-list-invoice?page=$pages&pageSize=$sizes&comEmail=$comEmail&sort=filename:$sort,uploadDate:$sort";
    http.get(url, headers: {
      "token": Provider.of<AuthProvider>(context, listen: false).token
    }).then((response) {
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        List<Document> docs = [];
        for (var doc in data["data"]["invoice_list"]) {
          var newDoc = Document(
            companyId: doc["_id"]["\$oid"],
            name: doc["filename"],
            userUpdateId: doc["uploadUser"],
            lastUpdate: doc["verifyInfo"]["VerifyDate"],
          );
          newDoc.getStatus(doc["verifyInfo"]["sellerActiveInfo"]["Status"]);
          docs.add(newDoc);
        }
        Provider.of<DocumentProvider>(context, listen: false)
            .setDocuments(docs);
      }
    }).catchError((error) => print(error));
  }

  static Future<void> addDocument(
      BuildContext context, String comEmail, String userName, File file) async {
    var length = await file.length();
    var uri = Uri.parse(
        "http://service-invoice-fda-demo.paas.xplat.fpt.com.vn/mobile-upload-file");
    var multipartFile = new http.MultipartFile('file', file.openRead(), length);
    var request = new http.MultipartRequest("POST", uri)
      ..headers.addAll({
        "token": Provider.of<AuthProvider>(context, listen: false).token,
        "Content-Length": "multipart/form-data",
      })
      ..fields["comEmail"] = comEmail
      ..fields["userName"] = userName
      ..files.add(multipartFile);

    request.send().then((response) {
      print(response.statusCode);
      print(request.headers.entries);
    }).catchError((err) => print(err));
  }
}
