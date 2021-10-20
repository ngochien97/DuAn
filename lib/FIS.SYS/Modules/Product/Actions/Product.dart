import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Product/ProductItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class ShopProduct extends StatefulWidget {
  ShopProduct({Key key}) : super(key: key);

  @override
  _ShopProductState createState() => _ShopProductState();
}

class _ShopProductState extends State<ShopProduct> {
  List<ProductItems> data = [
    ProductItems(
      image: "lib/G-Store/Assets/img (4).png",
      name: "Cơm trắng thịt ba chỉ",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductItems(
      image: "lib/G-Store/Assets/img (5).png",
      name: "Bò sốt tiêu (Ăn thêm)",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductItems(
      image: "lib/G-Store/Assets/img (4).png",
      name: "Cơm trắng thịt ba chỉ",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductItems(
      image: "lib/G-Store/Assets/img (4).png",
      name: "Cơm trắng thịt ba chỉ",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductItems(
      image: "lib/G-Store/Assets/img (4).png",
      name: "Cơm trắng thịt ba chỉ",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
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
            padding: EdgeInsets.all(8),
            child: FCard(
              hasPadding: false,
              hasShadow: false,
              backgroundColor: FColors.grey1,
              avatar: FBoundingBox(
                size: FBoxSize.auto_square,
                type: FBoundingBoxType.square,
                child: Container(
                  height: 163,
                  child: Image.asset(item.image),
                ),
              ),
              title: Container(
                height: 44,
                child: FText(
                  item.name,
                  style: FTextStyle.titleModules5,
                ),
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
                        icon: FFilledIcons.clock_circle,
                        size: 16,
                        color: [FColors.grey6],
                      ),
                      FText(item.location),
                    ],
                  ),
                ],
              ),
              actionChildren: [
                FDivider(),
                Row(
                  children: [
                    FText(
                      item.price + " đ",
                      color: FColors.red6,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    FIconButton(
                      icon: FOutlinedIcons.ellipsis,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: FColors.transparent,
                      color: FColors.grey6,
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
