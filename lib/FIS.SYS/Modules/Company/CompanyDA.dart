import 'package:Framework/FDA/Models/Company.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Modules/BaseDA.dart';
import 'package:flutter/widgets.dart';
export '../BaseDA.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

class CompanyDA extends BaseDA {
  static String url = "mobile-get-list-company";

  static Future<void> getCompanies(BuildContext context) async {
    http.get(BaseDA.domaniApi + url, headers: {
      "token": Provider.of<AuthProvider>(context).token
    }).then((response) {
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        List<Company> companies = [];
        for (var company in data["data"][0]["comList"]) {
          companies.add(
            Company(
                id: company["companyId"],
                companyName: company["companyName"],
                comEmail: company["email"],
                documentNumber: company["documentNumber"],
                avatar: company["avatarBase64"]),
          );
        }
        Provider.of<CompanyProvider>(context, listen: false)
            .setCompanies(companies);
      }
    }).catchError((error) => print(error));
  }
}
