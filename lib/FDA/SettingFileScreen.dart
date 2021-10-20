import 'dart:io';

import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/ToolBar.dart';
import 'package:Framework/FIS.SYS/Layout/Full.dart';
import 'package:Framework/FIS.SYS/Modules/Document/DocumentDA.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class SettingFileScreen extends StatefulWidget {
  SettingFileScreen();
  @override
  _SettingFileScreenState createState() => _SettingFileScreenState();
}

class _SettingFileScreenState extends State<SettingFileScreen> {
  String fileName = "Photo" + DateTime.now().toString();
  String selectedComId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    var _file = File(args["file"].toString().replaceFirst("file://", ""));
    return FullLayout(
      backGround: FColors.grey3,
      appBar: FAppBar(
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Cài đặt file',
            style: FTextStyle.titleModules3,
          ),
        ),
        headerLead: FIconButton(
          icon: FOutlinedIcons.left,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          onPressed: () {
            Navigator.pop(context);
          },
          color: FColors.grey9,
        ),
      ),
      body: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: FListTitle(
                  title: FText('Tên File'),
                  subtitle: FText(fileName),
                  round: true,
                  action: [
                    FButton(
                      title: 'Sửa',
                      backgroundColor: FColors.transparent,
                      color: FColors.grey7,
                      onPressed: () {
                        FBottomSheet.showFBottomSheet(
                          context,
                          FBottomSheet(
                            initialChildSize: 0.95,
                            enableDrag: false,
                            header: FModal(
                              title: FText(
                                'Sửa tên file',
                                style: FTextStyle.buttonText1,
                              ),
                              centerTitle: true,
                            ),
                            body: FTextField(
                              size: FTextFieldSize.size56,
                              autoFocus: true,
                              label: "Tên file",
                              value: fileName,
                              onChanged: (v) {
                                setState(() {
                                  fileName = v;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      rightIcon: FOutlinedIcons.edit,
                      size: FButtonSize.size48,
                      block: true,
                    ),
                  ],
                  avatar: FBoundingBox(
                    backgroundColor: FColors.green2,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      color: [FColors.green6, FColors.transparent],
                      size: 20,
                      icon: FFilledIcons.document,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: FListTitle(
                  title: FText('Lưu vào folder'),
                  subtitle: FText('Recent'),
                  round: true,
                  action: [
                    FButton(
                      title: 'Sửa',
                      backgroundColor: FColors.transparent,
                      color: FColors.grey7,
                      onPressed: () {
                        FBottomSheet.showFBottomSheet(
                          context,
                          FBottomSheet(
                            enableDrag: false,
                            initialChildSize: 0.95,
                            header: FModal(
                              title: FText(
                                'Sửa tên file',
                                style: FTextStyle.buttonText1,
                              ),
                              centerTitle: true,
                            ),
                            body: ListView(
                              children: [
                                for (var company
                                    in Provider.of<CompanyProvider>(context,
                                            listen: false)
                                        .getCompanies)
                                  FListTitle(
                                    title: FText(company.companyName),
                                    round: true,
                                    avatar: FBoundingBox(
                                      size: FBoxSize.size48x48,
                                      child: Image.memory(
                                        convert.base64Decode(
                                          company.avatar.replaceFirst(
                                              "data:image/png;base64,", ""),
                                        ),
                                      ),
                                    ),
                                    action: [
                                      FRadioButton(
                                        groupValue: selectedComId,
                                        value: company.id,
                                        toggle: true,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedComId = value;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      rightIcon: FOutlinedIcons.edit,
                      size: FButtonSize.size48,
                      block: true,
                    ),
                  ],
                  avatar: FBoundingBox(
                    backgroundColor: FColors.green2,
                    size: FBoxSize.size32x32,
                    child: FIcon(
                      color: [FColors.green6, FColors.transparent],
                      size: 20,
                      icon: FFilledIcons.folder_open,
                    ),
                  ),
                ),
              ),
              Image.file(
                _file,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
      bottom: FToolBar(children: [
        FToolBarItem(
          title: 'Xóa',
          color: FColors.blue6,
          onTap: () {},
        ),
        FToolBarItem(
          title: 'Share',
          color: FColors.blue6,
          onTap: () {},
        ),
        FToolBarItem(
          title: 'Lưu',
          color: FColors.blue6,
          onTap: () {
            DocumentDA.addDocument(context, "dohuan0987@invoicenet.vn",
                "daily.qc@gmail.com", _file);
          },
        ),
      ]),
    );
  }
}
