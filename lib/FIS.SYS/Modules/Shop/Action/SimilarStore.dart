import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/ShopItems.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class SimilarStore extends StatefulWidget {
  SimilarStore({Key key}) : super(key: key);

  @override
  _SimilarStoreState createState() => _SimilarStoreState();
}

class _SimilarStoreState extends State<SimilarStore> {
  List<ShopItems> data = [
    ShopItems(
      id: 1,
      image: "lib/G-Store/Assets/img (1).png",
      armorial: "Cửa hàng uy tín",
      rank: "1",
      name: "Ốc rang me",
      address: "Số 2 Hoàng Ngọc Phách - Quận Đống Đa",
      rating: "4.4(80)",
      location: "1.6 Km",
      type: "Đồ ăn",
      vote: "166",
    ),
    ShopItems(
      id: 1,
      image: "lib/G-Store/Assets/img (2).png",
      armorial: "Cửa hàng uy tín",
      rank: "1",
      name: "Thế giới chè Caramen",
      address: "hố Trung Liệt - Quận Đống Đa đoạn cắt Trung Liệt - Thái Thịnh",
      rating: "4.4(80)",
      location: "1.6 Km",
      type: "Đồ ăn",
      vote: "166",
    ),
    ShopItems(
      id: 1,
      image: "lib/G-Store/Assets/img (6).png",
      armorial: "Cửa hàng uy tín",
      rank: "1",
      name: "Hạt Dẻ Cười Fastfood",
      address: "B13 - 23 Lương Định Của - Quận Đống Đa (Quán Hưng Ốc)",
      rating: "4.4(80)",
      location: "1.6 Km",
      type: "Đồ ăn",
      vote: "166",
    ),
    ShopItems(
      id: 1,
      image: "lib/G-Store/Assets/img (1).png",
      armorial: "Cửa hàng uy tín",
      rank: "1",
      name: "Shop đồ ăn vặt Bông Meomeo",
      address: "Số 2 Hoàng Ngọc Phách - Quận Đống Đa",
      rating: "4.4(80)",
      location: "1.6 Km",
      type: "Đồ ăn",
      vote: "166",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var item in data)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  FListTitle(
                    height: 124,
                    title: FText(
                      item.name,
                      style: FTextStyle.titleModules5,
                    ),
                    subtitle: FText(
                      item.address,
                      style: FTextStyle.subtitle2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    avatar: FBoundingBox(
                      size: FBoxSize.auto_rectangle,
                      child: Container(
                        width: 124 * 4 / 3,
                        color: FColors.grey6,
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    bottomAction: [
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
                      FSpacer.hozirontalSpace8px,
                      Row(
                        children: [
                          FIcon(
                            icon: FFilledIcons.like,
                            size: 16,
                            color: [SkinColor.primary],
                          ),
                          FText(item.vote),
                        ],
                      ),
                    ],
                  ),
                  FSpacer.space16px,
                ],
              ),
              // );
              // }),
            ),
        ],
      ),
    );
  }
}
