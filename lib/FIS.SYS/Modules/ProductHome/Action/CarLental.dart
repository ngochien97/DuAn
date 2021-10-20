import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/IconButton.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/ProductHomeItem.dart';

class CarLental extends StatefulWidget {
  @override
  _CarLentalState createState() => _CarLentalState();
}

class _CarLentalState extends State<CarLental> {
  List<ProductHomeItems> data = [
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image12.png",
      name: "Cho thuê xe ô tô tự lái TOYOTA VIOS",
      speed: "500,000 đ/KM",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image13.png",
      name: "Cho thuê xe ô tô tự lái Mazda CX5",
      speed: "500,000 đ/KM",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image12.png",
      name: "Cho thuê xe tự lái Nissan Sunny",
      speed: "500,000 đ/KM",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image13.png",
      name: "Cho thuê xe tự lái Nissan Sunny",
      speed: "500,000 đ/KM",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
    ProductHomeItems(
      image: "lib/G-Store/Assets/Image12.png",
      name: "Cho thuê xe tự lái Nissan Sunny",
      speed: "500,000 đ/KM",
      location: "1.6 Km",
      rating: "4.4(80)",
    ),
  ];
  BuildContext oldDialogContext;
  onDismiss() {
    if (oldDialogContext != null) {
      Navigator.of(oldDialogContext).pop();
    }
    this.oldDialogContext = null;
  }

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
                      item.speed,
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
                      onPressed: () {
                        if (oldDialogContext != null) {
                          onDismiss();
                        }
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            oldDialogContext = context;

                            return AlertDialog(
                              scrollable: true,
                              title: Row(
                                children: [
                                  FIconButton(
                                    icon: FOutlinedIcons.close,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: FColors.transparent,
                                    color: FColors.grey10,
                                    onPressed: onDismiss,
                                  ),
                                  SizedBox(width: 60),
                                  FText(
                                    'Tác vụ',
                                    style: FTextStyle.titleModules3,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              content: Container(
                                child: Column(
                                  children: [
                                    FButton(
                                      title: 'Mua ngay',
                                      onPressed: () {},
                                      backgroundColor: FColors.grey3,
                                      color: FColors.grey9,
                                      size: FButtonSize.size48,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      block: true,
                                      leftIcon: FOutlinedIcons.aliyun,
                                    ),
                                    SizedBox(height: 8),
                                    FButton(
                                      title: 'Thêm vào giỏ hàng',
                                      onPressed: () {},
                                      backgroundColor: FColors.grey3,
                                      color: FColors.grey9,
                                      size: FButtonSize.size48,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      block: true,
                                      leftIcon: FOutlinedIcons.delivery,
                                    ),
                                    SizedBox(height: 8),
                                    FButton(
                                      title: 'thêm vào yêu thích',
                                      onPressed: () {},
                                      backgroundColor: FColors.grey3,
                                      color: FColors.grey9,
                                      size: FButtonSize.size48,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      block: true,
                                      leftIcon: FOutlinedIcons.heart,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
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
