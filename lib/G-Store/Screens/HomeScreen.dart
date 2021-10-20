import 'package:Framework/FIS.SYS/Components/TabBar.dart';
import 'package:Framework/FIS.SYS/Modules/Header/Action/ShopHomeHeader.dart';
import 'package:Framework/FIS.SYS/Modules/Home/Action/HomeDetail.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {
        'screen': HomeDetail(),
        'title': "Trang chủ",
        'icon': FFilledIcons.shop_location,
      },
      {
        'screen': Container(),
        'title': "Danh mục",
        'icon': FOutlinedIcons.grid,
      },
      {
        'screen': Container(),
        'title': "Giỏ hàng",
        'icon': FOutlinedIcons.delivery,
      },
      {
        'screen': Container(),
        'title': "Tin tức",
        'icon': FOutlinedIcons.document,
      },
      // {
      //   'screen': Container(),
      //   'title': "Cá nhân",
      //   'icon': FOutlinedIcons.user_1,
      // },
    ];
    return Scaffold(
      backgroundColor: FColors.grey3,
      appBar: ShopHomeHeader(),
      body: SingleChildScrollView(
        child: items[currentIndex]['screen'],
      ),
      bottomNavigationBar: FTabBar(
        currentIndex: currentIndex,
        selectedColor: SkinColor.primary,
        children: [
          for (var element in items)
            FTabBarItem(
              icon: element['icon'],
              title: element['title'],
              onTap: (index) {
                if (currentIndex == index) {
                  return;
                } else {
                  setState(() {
                    currentIndex = index;
                  });
                }
              },
            ),
        ],
      ),
    );
  }
}
