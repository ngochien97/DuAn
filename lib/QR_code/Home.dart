import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeQR extends StatefulWidget {
  @override
  _HomeQRState createState() => _HomeQRState();
}

class _HomeQRState extends State<HomeQR> {
  var locationMessage = '';
  void getCurrentLocation() async {
    var possion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);

    setState(() {
      locationMessage = '$possion.altitude , $possion.longitude';
    });
  }

  List<Map<String, dynamic>> data = [
    {
      'title': 'Bạn có bị sốt không?',
      'yes': 'Có',
      'no': 'Không',
      'isCheck1': false,
      'isCheck2': false,
    },
    {
      'title': 'Bạn có bị đau, xưng tấy vùng tiêm hay không?',
      'yes': 'Có',
      'no': 'Không',
      'isCheck1': false,
      'isCheck2': false,
    },
    {
      'title': 'Bạn có đau nhức cơ thể hay không?',
      'yes': 'Có',
      'no': 'Không',
      'isCheck1': false,
      'isCheck2': false,
    },
    {
      'title': 'Bạn có bị rối loạn giấc ngủ hay không?',
      'yes': 'Có',
      'no': 'Không',
      'isCheck1': false,
      'isCheck2': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: FAppBar(
          headerCenter: FText(
            'Đánh giá sức khỏe',
            style: FTextStyle.buttonText1,
          ),
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            backgroundColor: FColors.grey1,
            color: FColors.grey9,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      FText(
                        'Bảng đánh giá sức khỏe',
                        style: FTextStyle.titleModules2,
                        color: FColors.red6,
                      ),
                      SizedBox(height: 12),
                      Column(
                        children: [
                          for (var item in data)
                            Container(
                              child: Column(
                                children: [
                                  FText(
                                    item['title'],
                                    style: FTextStyle.titleModules4,
                                    maxLines: 2,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FCheckbox(
                                          value: item['isCheck1'],
                                          onChanged: (val) {
                                            setState(() {
                                              item['isCheck1'] =
                                                  !item['isCheck1'];
                                            });
                                          },
                                        ),
                                        FText('Có'),
                                        Expanded(child: Container()),
                                        FCheckbox(
                                          value: item['isCheck2'],
                                          onChanged: (val) {
                                            setState(() {
                                              item['isCheck2'] =
                                                  !item['isCheck2'];
                                            });
                                          },
                                        ),
                                        FText('Không'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      FTextField(
                        label: 'Triệu chứng khác',
                        size: FTextFieldSize.size40,
                      ),
                    ],
                  ),
                ),
                FText(locationMessage),
                Container(
                  child: FButton(
                    title: 'Cập nhật vị trí',
                    backgroundColor: FColors.green6,
                    color: FColors.grey9,
                    rightIcon: FOutlinedIcons.heat_map,
                    onPressed: () {
                      getCurrentLocation();
                    },
                  ),
                ),
                Container(
                  child: FButton(
                    title: 'Hoàn thành ',
                    backgroundColor: FColors.green6,
                    color: FColors.grey9,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          child: FButton(
            title: 'Hotline: 0383821611',
            backgroundColor: FColors.blue6,
            color: FColors.grey9,
            leftIcon: FFilledIcons.phone,
            onPressed: () {
              launch("tel://0383821611");
            },
          ),
        ),
      ),
    );
  }
}
