import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Company/CompanyDA.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class ListCompany extends StatefulWidget {
  final Function onRefresh;

  ListCompany({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  _ListCompanyState createState() => _ListCompanyState();
}

class _ListCompanyState extends State<ListCompany> {
  @override
  void initState() {
    super.initState();
    getCompanyData();
  }

  Future<void> getCompanyData() async {
    CompanyDA companyDA = CompanyDA();
    var data = await companyDA.getCompanyData();
    var comProvider = Provider.of<CompanyProvider>(context, listen: false);
    comProvider.setListCompany(data.listComItem);
    comProvider.filterList('');
  }

  // Future<void> _refresh() async {
  //   widget.onRefresh();
  //   Provider.of<CompanyProvider>(context, listen: false).filterList('');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(17, 8, 15, 8),
      child: RefreshIndicator(
        onRefresh: () async {
          getCompanyData();
          widget.onRefresh();
        },
        child: Consumer<CompanyProvider>(
          builder: (context, comProvider, child) => ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: comProvider.getListCompany.length,
            cacheExtent: 250,
            itemBuilder: (context, index) {
              var company = comProvider.getListCompany[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    comProvider.setCurrentCompany(company);
                    Navigator.pushNamed(context, '/detailFolder_screen',
                        arguments: {
                          "comEmail": company.email,
                          "title": company.companyName,
                        });
                  },
                  child: FListTitle(
                    title: FText(company.companyName),
                    round: true,
                    subtitle: FText(
                      "${company.numFileDone.toString()}/" +
                          "${(company.numFileDone + company.numFileWait + company.numFileFail + company.numFileDelete).toString()}" +
                          " files đã nhận dạng",
                      style: FTextStyle.subtitle2,
                    ),
                    avatar: FBoundingBox(
                      type: FBoundingBoxType.circle,
                      size: FBoxSize.size48x48,
                      child: company.avatarBase64 != ""
                          ? Image.memory(
                              convert.base64Decode(company.avatarBase64
                                  .replaceFirst("data:image/png;base64,", "")),
                            )
                          : Container(),
                    ),
                  ),
                ),
              );
            },
          ),
          // Column(
          //   children: [
          //   for (var company in companyProvider.getListCompany)
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 8.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pushNamed(context, '/detailFolder_screen',
          //           arguments: {
          //             "comEmail": company.email,
          //             "title": company.companyName,
          //           });
          //     },
          //     child: FListTitle(
          //       title: FText(company.companyName),
          //       round: true,
          //       subtitle: FText(
          //         "${company.documentNumber.toString()} ${company.documentNumber == 1 ? "File" : "Files"}",
          //         style: FTextStyle.subtitle2,
          //       ),
          //       avatar: FBoundingBox(
          //         type: FBoundingBoxType.circle,
          //         size: FBoxSize.size48x48,
          //         child: Image.memory(
          //           convert.base64Decode(company.avatarBase64
          //               .replaceFirst("data:image/png;base64,", "")),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // ]),
        ),
      ),
    );
  }
}
