import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/FilterCategory/Action/FilterCategory.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/ProductHomeItem.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

class SearchMap extends StatefulWidget {
  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  List<ProductHomeItems> data = [
    ProductHomeItems(
      id: 1,
      image: "lib/G-Store/Assets/Image14.png",
      rank: "1",
      name: "Macbook Pro 15 inch 2019 - i5/16GB/512GB ...",
      rating: "4.4(80)",
      location: "1.6 Km",
      price: "22,000",
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
    return Scaffold(
      body: Container(
        color: FColors.grey1,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child:
                  Image.asset('lib/G-Store/Assets/Map.png', fit: BoxFit.fill),
            ),
            Container(
              padding: EdgeInsets.only(top: 44),
              child: Row(
                children: [
                  FIconButton(
                    icon: FOutlinedIcons.left,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    backgroundColor: FColors.grey1,
                    color: FColors.grey10,
                    size: FIconButtonSize.size40,
                  ),
                  Expanded(
                    child: FTextField(
                      label: 'Bạn muốn tìm gì',
                      leftIcon: FOutlinedIcons.search,
                      size: FTextFieldSize.size40,
                    ),
                  ),
                  FIconButton(
                    icon: FOutlinedIcons.filter,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    backgroundColor: FColors.grey1,
                    color: FColors.grey10,
                    size: FIconButtonSize.size40,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 450, left: 16),
              child: Column(
                children: [
                  for (var item in data)
                    FListTitle(
                      height: 140,
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
                      bottomAction: [
                        FDivider(),
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
                          onPressed: () {
                            if (oldDialogContext != null) {
                              onDismiss();
                            }
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                oldDialogContext = context;

                                return FBottomSheet(
                                  mainAxisSize: MainAxisSize.max,
                                  header: FModal(
                                    iconAction: FIconButton(
                                      icon: FOutlinedIcons.close,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: FColors.transparent,
                                      color: FColors.grey10,
                                      onPressed: onDismiss,
                                    ),
                                    textAction: FButton(
                                      title: 'Reset',
                                      onPressed: () {},
                                      backgroundColor: FColors.grey1,
                                      color: FColors.blue6,
                                    ),
                                    title: Container(
                                      child: FText(
                                        'Bộ lọc',
                                        style: FTextStyle.titleModules3,
                                        textAlign: TextAlign.center,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    bottom: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(16),
                                          alignment: Alignment.topLeft,
                                          color: FColors.grey1,
                                          child: Column(
                                            children: [
                                              FText(
                                                'Lọc theo khoảng cách',
                                                style: FTextStyle.titleModules5,
                                                decoration: TextDecoration.none,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(height: 4),
                                        Container(
                                          margin: EdgeInsets.all(16),
                                          alignment: Alignment.topLeft,
                                          color: FColors.grey1,
                                          child: Column(
                                            children: [
                                              FText(
                                                'Lọc theo giá',
                                                style: FTextStyle.titleModules5,
                                                decoration: TextDecoration.none,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [],
                                          ),
                                        ),
                                        Divider(),
                                        Container(
                                          margin: EdgeInsets.all(16),
                                          alignment: Alignment.topLeft,
                                          color: FColors.grey1,
                                          child: Column(
                                            children: [
                                              FText(
                                                'Lọc theo danh mục',
                                                style: FTextStyle.titleModules5,
                                                decoration: TextDecoration.none,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: FilterCategory(),
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
