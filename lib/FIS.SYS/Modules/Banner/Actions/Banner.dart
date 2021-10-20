import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Banner/BannerItems.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShopBanner extends StatefulWidget {
  ShopBanner({Key key}) : super(key: key);

  @override
  _ShopBannerState createState() => _ShopBannerState();
}

class _ShopBannerState extends State<ShopBanner> {
  List<BannerItems> data = [
    BannerItems(image: 'lib/G-Store/Assets/img (1).jpg'),
    BannerItems(image: 'lib/G-Store/Assets/img (2).jpg'),
    BannerItems(image: 'lib/G-Store/Assets/img (3).jpg'),
    BannerItems(image: 'lib/G-Store/Assets/img (4).jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      child: PageView(
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.start,
        children: [
          for (var item in data)
            FBoundingBox(
              size: FBoxSize.auto_rectangle_special,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
              backgroundColor: FColors.grey10.withOpacity(0.4),
              topItems: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 56),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: FIconButton(
                        icon: FOutlinedIcons.left,
                        onPressed: () {},
                        backgroundColor: FColors.grey10.withOpacity(0.4),
                      ),
                    ),
                    Expanded(child: Container()),
                    FIconButton(
                      icon: FOutlinedIcons.share_alt,
                      onPressed: () {},
                      backgroundColor: FColors.grey10.withOpacity(0.4),
                    ),
                    FIconButton(
                      icon: FOutlinedIcons.heart,
                      onPressed: () {},
                      backgroundColor: FColors.grey10.withOpacity(0.4),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: FIconButton(
                        icon: FOutlinedIcons.search,
                        onPressed: () {},
                        backgroundColor: FColors.grey10.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
              bottomItems: Container(
                margin: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: FColors.grey10.withOpacity(0.4),
                  ),
                  child: FText(
                    (data.indexOf(item) + 1).toString() + "/${data.length}",
                    color: FColors.grey1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
