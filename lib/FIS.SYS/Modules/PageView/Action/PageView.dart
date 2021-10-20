import 'package:Framework/FIS.SYS/Components/BoundingBox.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/PageView/PageViewItem.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<PageView1> data = [
    PageView1(image: 'lib/G-Store/Assets/Image5.png'),
    PageView1(image: 'lib/G-Store/Assets/Image6.png'),
    PageView1(image: 'lib/G-Store/Assets/Image7.png'),
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
              bottomItems: Container(
                margin: EdgeInsets.all(20),
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
