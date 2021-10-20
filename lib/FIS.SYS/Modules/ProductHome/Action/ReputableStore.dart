import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/IconButton.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/ProductHomeItem.dart';
import 'package:flutter/material.dart';

class ReputableStore extends StatefulWidget {
  @override
  _ReputableStoreState createState() => _ReputableStoreState();
}

class _ReputableStoreState extends State<ReputableStore> {
  List<ProductHomeItems> data = [
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image8.png",
      name: "KFC - The manor Hà Nội",
      address: "Tầng 1,Vincom Center Phạm Ngọc Thạch, Đống Đa",
      like: "450 thích",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image9.png",
      name: "Bếp Bà Lan - Thiên Hiển",
      address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
      like: "450 thích",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image8.png",
      name: "Cơm thố tấn lộc",
      address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
      like: "450 thích",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image9.png",
      name: "Cơm thố tấn lộc",
      address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
      like: "450 thích",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image8.png",
      name: "Cơm thố tấn lộc",
      address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
      like: "450 thích",
      rating: "4.4(80)",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: FColors.grey1,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var item = data[index];
          return Container(
            color: FColors.grey1,
            width: 163,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: FCard(
              hasPadding: false,
              hasShadow: false,
              backgroundColor: FColors.grey1,
              avatar: FBoundingBox(
                size: FBoxSize.auto_rectangle,
                child: Container(
                  height: 122,
                  child: Image.asset(item.image),
                ),
                bottomItems: Container(
                  margin: EdgeInsets.all(4),
                  child: Container(
                    child: FIconButton(
                      icon: FFilledIcons.shield,
                      color: SkinColor.primary,
                      backgroundColor: FColors.grey1,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              title: Column(
                children: [
                  Container(
                    height: 44,
                    child: FText(
                      item.name,
                      style: FTextStyle.titleModules5,
                    ),
                  ),
                  Container(
                    child: FText(
                      item.address,
                      style: FTextStyle.subtitle2,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      FIcon(
                        icon: FFilledIcons.star,
                        size: 16,
                        color: [FColors.yellow6],
                      ),
                      FText(item.rating),
                    ],
                  ),
                  Row(
                    children: [
                      FIcon(
                        icon: FFilledIcons.like,
                        size: 16,
                        color: [FColors.green4],
                      ),
                      FText(item.like),
                    ],
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
