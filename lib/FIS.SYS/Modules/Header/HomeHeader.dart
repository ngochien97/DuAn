import 'package:Framework/FDA/Models/Company.dart';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FAppBar homeHeader(BuildContext context) {
  String searchName;

  return FAppBar(
    bodyTitle: FText(
      'FPT Scan',
      style: FTextStyle.titleModules2,
    ),
    avatar: FBoundingBox(
      type: FBoundingBoxType.circle,
      backgroundColor: FColors.green6,
      size: FBoxSize.size32x32,
      child: FIconButton(
        icon: FFilledIcons.user,
        color: FColors.grey1,
        size: FIconButtonSize.size32,
        onPressed: () {
          Navigator.pushNamed(context, 'profile_screen');
        },
        backgroundColor: FColors.transparent,
      ),
    ),
    bottom: FTextField(
      label: "Tìm tên công ty",
      leftIcon: FOutlinedIcons.search,
      backgroundColor: FColors.grey3,
      size: FTextFieldSize.size40,
      value: searchName,
      onChanged: (value) {
        List<Company> companies =
            Provider.of<CompanyProvider>(context, listen: false).getCompanies;

        searchName = value;
        companies = companies
            .where((element) => element.companyName
                .toLowerCase()
                .contains(searchName.toLowerCase()))
            .toList();

        Provider.of<CompanyProvider>(context, listen: false).setData(companies);
        // for (var ele in companies) {
        //   if (ele.companyName.contains(value)) {
        //     print(ele.companyName);
        //     print(ele.companyName.contains(searchName));
        //   }
        // }
        //     searchCompanies.add(Company(
        //       id: ele.id,
        //       avatar: ele.avatar,
        //       comEmail: ele.comEmail,
        //       companyName: value,
        //       documentNumber: ele.documentNumber,
        //     ));
        //   }
        // }
        // print(searchCompanies);
        // Provider.of<CompanyProvider>(context).setData(searchCompanies);
      },
    ),
  );
}
