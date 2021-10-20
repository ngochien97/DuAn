import 'dart:ui';

import 'package:Framework/FIS.SYS/Components/Button.dart';
import 'package:Framework/FIS.SYS/Components/IconButton.dart';
import 'package:Framework/FIS.SYS/Components/TabBar.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Modules/PageView/Action/PageView.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/Buys.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/Carlental.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/Computer.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/Fashion.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/NearbyStore.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/Product1.dart';
import 'package:Framework/FIS.SYS/Modules/ProductHome/Action/ReputableStore.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class HomeDetail extends StatefulWidget {
  @override
  _HomeDetailState createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: FColors.grey1,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: FColors.grey3,
                      padding: EdgeInsets.all(16),
                      child: Image.asset('lib/G-Store/Assets/bando.png'),
                    ),
                    Container(
                      child: FButton(
                        title: 'Tìm quanh tôi',
                        rightIcon: FOutlinedIcons.right,
                        onPressed: () {},
                        backgroundColor: FColors.grey1,
                        color: FColors.grey9,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                        child: Row(
                          children: [
                            FText(
                              'Sản phẩm tốt gần bạn',
                              style: FTextStyle.titleModules3,
                              color: FColors.grey9,
                            ),
                            Expanded(child: Container()),
                            FButton(
                              title: 'Tất cả',
                              backgroundColor: FColors.grey1,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {},
                              color: FColors.blue6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                        child: HomeProduct(),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: HomePageView(),
                ),
                Container(
                  color: FColors.grey3,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        color: FColors.grey1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Row(
                                children: [
                                  FIconButton(
                                    icon: FFilledIcons.shield,
                                    color: SkinColor.primary,
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                  ),
                                  FText(
                                    'Cửa hàng uy tín',
                                    style: FTextStyle.titleModules3,
                                    color: SkinColor.primary,
                                  ),
                                  Expanded(child: Container()),
                                  FButton(
                                    title: 'Tất cả',
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    color: FColors.blue6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: ReputableStore(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: FColors.grey1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                              child: Row(
                                children: [
                                  FText(
                                    'Được mua nhiều',
                                    style: FTextStyle.titleModules3,
                                    color: FColors.grey9,
                                  ),
                                  Expanded(child: Container()),
                                  FButton(
                                    title: 'Tất cả',
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    color: FColors.blue6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: Buys(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: FColors.grey3,
                        child: Image.asset('lib/G-Store/Assets/Image6.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        color: FColors.grey1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                              child: Row(
                                children: [
                                  FText(
                                    'Thời trang',
                                    style: FTextStyle.titleModules3,
                                    color: FColors.grey9,
                                  ),
                                  Expanded(child: Container()),
                                  FButton(
                                    title: 'Tất cả',
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    color: FColors.blue6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: Fashion(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        color: FColors.grey1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                              child: Row(
                                children: [
                                  FText(
                                    'Cho thuê xe',
                                    style: FTextStyle.titleModules3,
                                    color: FColors.grey9,
                                  ),
                                  Expanded(child: Container()),
                                  FButton(
                                    title: 'Tất cả',
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    color: FColors.blue6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: CarLental(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 1),
                        color: FColors.grey1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                              child: Row(
                                children: [
                                  FText(
                                    'Máy tính',
                                    style: FTextStyle.titleModules3,
                                    color: FColors.grey9,
                                  ),
                                  Expanded(child: Container()),
                                  FButton(
                                    title: 'Tất cả',
                                    backgroundColor: FColors.grey1,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    color: FColors.blue6,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: Computer(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: DefaultTabController(
                          length: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Scaffold(
                              appBar: AppBar(
                                backgroundColor: FColors.grey1,
                                bottom: TabBar(
                                  indicatorColor: SkinColor.primary,
                                  labelColor: FColors.grey6,
                                  unselectedLabelColor: SkinColor.primary,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Tab(child: FText("Gần tôi")),
                                    Tab(child: FText("Giảm giá mạnh")),
                                    Tab(child: FText("Giao nhanh")),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  Container(
                                    child: NearbyStore(),
                                  ),
                                  Container(),
                                  Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
