import 'package:Framework/FIS.SYS/Components/AppBar.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/ProductHomeItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<ProductHomeItems> data = [
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image3.png",
      name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image1.png",
      name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image1.png",
      name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image2.png",
      name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image3.png",
      name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
      price: "22,000",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FColors.grey1,
          title: Row(
            children: [
              FIconButton(
                icon: FOutlinedIcons.left,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {},
                backgroundColor: FColors.grey1,
                color: FColors.grey10,
              ),
              FText(
                'Thời Trang',
                textAlign: TextAlign.center,
                style: FTextStyle.titleModules3,
                fontFamily: 'Roboto',
              ),
              Expanded(child: Container()),
              FIconButton(
                icon: FOutlinedIcons.search,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {},
                backgroundColor: FColors.grey1,
                color: FColors.grey10,
              ),
              FIconButton(
                icon: FOutlinedIcons.filter,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {},
                backgroundColor: FColors.grey1,
                color: FColors.grey10,
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: SkinColor.primary,
            labelColor: FColors.grey6,
            unselectedLabelColor: SkinColor.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: FText("Gần tôi(10)")),
              Tab(child: FText("Bán chạy(50)")),
              Tab(child: FText("Giao nhanh(10)")),
              Tab(child: FText("Đánh giá(20)")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: FColors.grey3,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, indext) {
                  var item = data[indext];
                  return Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        color: FColors.grey1,
                        width: 172,
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
                            bottomItems: Container(
                              margin: EdgeInsets.all(4),
                              child: Container(
                                child: FIconButton(
                                  icon: FFilledIcons.star,
                                  color: SkinColor.primary,
                                  backgroundColor: FColors.grey1,
                                  onPressed: () {},
                                ),
                              ),
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: FColors.transparent,
                                  color: FColors.grey6,
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: FColors.grey1,
                        width: 172,
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
                            bottomItems: Container(
                              margin: EdgeInsets.all(4),
                              child: Container(
                                child: FIconButton(
                                  icon: FFilledIcons.star,
                                  color: SkinColor.primary,
                                  backgroundColor: FColors.grey1,
                                  onPressed: () {},
                                ),
                              ),
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: FColors.transparent,
                                  color: FColors.grey6,
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
