import 'package:Framework/FIS.SYS/Components/Card.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/ShopItems.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

class HeaderStore extends StatefulWidget {
  HeaderStore({Key key}) : super(key: key);

  @override
  _HeaderStoreState createState() => _HeaderStoreState();
}

class _HeaderStoreState extends State<HeaderStore> {
  ShopItems storeData = new ShopItems(
    armorial: "Cửa hàng uy tín",
    rank: "1",
    name: "Quán Bà Lan - Thiên Hiển",
    address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
    rating: "4.4(80)",
    location: "1.6 Km",
    type: "Đồ ăn",
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FCard(
        // topItems:
        title: Row(
          children: [
            Row(
              children: [
                FIcon(
                  icon: FFilledIcons.shield,
                  color: [SkinColor.primary],
                ),
                FText(
                  storeData.armorial + " - ",
                  color: SkinColor.primary,
                ),
                GestureDetector(
                  child: FText(
                    storeData.type,
                    color: FColors.blue6,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        subtitle: FText(
          storeData.name,
          style: FTextStyle.titleModules2,
        ),
        content: Container(
          child: FText(storeData.address),
        ),
        actionChildren: [
          Row(
            children: [
              Row(
                children: [
                  FIcon(
                    icon: FFilledIcons.star,
                    size: 16,
                    color: [FColors.yellow6],
                  ),
                  FText(
                    storeData.rating,
                    color: FColors.grey6,
                  ),
                ],
              ),
              FSpacer.hozirontalSpace16px,
              Row(
                children: [
                  FIcon(
                    icon: FFilledIcons.clock_circle,
                    size: 16,
                    color: [FColors.grey6],
                  ),
                  FText(
                    storeData.location,
                    color: FColors.grey6,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
