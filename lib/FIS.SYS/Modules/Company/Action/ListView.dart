import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyDA.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class ListCompany extends StatefulWidget {
  ListCompany({Key key}) : super(key: key);

  @override
  _ListCompanyState createState() => _ListCompanyState();
}

class _ListCompanyState extends State<ListCompany> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CompanyDA.getCompanies(context);
  }

  @override
  Widget build(BuildContext context) {
    // CompanyDA.getCompanies(context);
    return Container(
      margin: EdgeInsets.fromLTRB(17, 8, 15, 8),
      child: Consumer<CompanyProvider>(
        builder: (context, companyProvider, child) => Column(
          children: [
            for (var company in companyProvider.getData)
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detailFolder_screen',
                        arguments: {
                          "comEmail": company.comEmail,
                          "title": company.companyName,
                        });
                  },
                  child: FListTitle(
                    title: FText(company.companyName),
                    round: true,
                    subtitle: FText(
                      "${company.documentNumber.toString()} ${company.documentNumber == 1 ? "File" : "Files"}",
                      style: FTextStyle.subtitle2,
                    ),
                    avatar: FBoundingBox(
                      size: FBoxSize.size48x48,
                      child: Image.memory(
                        convert.base64Decode(company.avatar
                            .replaceFirst("data:image/png;base64,", "")),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
