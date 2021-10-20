import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/ShopItems.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/ProductHomeItem.dart';
import 'package:flutter/material.dart';

class NearbyStore extends StatefulWidget {
  NearbyStore({Key key}) : super(key: key);

  @override
  _NearbyStoreState createState() => _NearbyStoreState();
}

class _NearbyStoreState extends State<NearbyStore> {
  List<ProductHomeItems> data = [
    ProductHomeItems(
      id: 1,
      image: "lib/G-Store/Assets/Image16.png",
      rank: "1",
      name: "Wescott Wingback FloralRecliner Club Chair ",
      rating: "4.4(80)",
      location: "1.6 Km",
      price: "22,000",
    ),
    ProductHomeItems(
      id: 1,
      image: "lib/G-Store/Assets/Image17.png",
      rank: "1",
      name: "Chuột Không Dây Logitech M720 Triathlon ",
      rating: "4.4(80)",
      location: "1.6 Km",
      price: "22,000",
    ),
    ProductHomeItems(
      id: 1,
      image: "lib/G-Store/Assets/Image18.png",
      rank: "1",
      name: "Đồng Hồ Treo Tường Kim Trôi Cao Cấp HONO",
      rating: "4.4(80)",
      location: "1.6 Km",
      price: "22,000",
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
                    // bottomAction: [
                    //   FDivider(),
                    //   FText(
                    //     item.price + " đ",
                    //     color: FColors.red6,
                    //   ),
                    //   Expanded(
                    //     child: Container(),
                    //   ),
                    //   FIconButton(
                    //     icon: FOutlinedIcons.ellipsis,
                    //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //     backgroundColor: FColors.transparent,
                    //     color: FColors.grey7,
                    //     onPressed: () {},
                    //   )
                    // ],
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                FIcon(
                                  icon: FFilledIcons.star,
                                  size: 16,
                                  color: [FColors.yellow6],
                                ),
                                FText(item.rating, style: FTextStyle.bodyText1),
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
                                FText(item.location),
                              ],
                            ),
                          ],
                        ),
                        FDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
