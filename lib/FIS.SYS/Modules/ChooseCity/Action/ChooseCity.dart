import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/ChooseCity/ChooseCityItem.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class ChooserCity extends StatefulWidget {
  @override
  _ChooserCityState createState() => _ChooserCityState();
}

class _ChooserCityState extends State<ChooserCity> {
  List<ChooseCityItem> cityName = [
    ChooseCityItem(name: 'Hà Nội'),
    ChooseCityItem(name: 'Thái Bình'),
    ChooseCityItem(name: 'Nam Định'),
    ChooseCityItem(name: 'Hải Dương'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      color: FColors.grey1,
      child: ListView.builder(
          itemCount: cityName.length,
          itemBuilder: (context, indext) {
            var item = cityName[indext];
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 13, 0, 13),
                    child: FText(
                      item.name,
                      style: FTextStyle.bodyText2,
                      color: FColors.grey9,
                    ),
                  ),
                  FDivider(),
                ],
              ),
            );
          }),
    );
  }
}
