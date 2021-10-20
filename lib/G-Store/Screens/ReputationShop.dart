import 'dart:ui';

import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Modules/Banner/Actions/Banner.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/Action/Information.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/Action/Store.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class ReputationShopScreen extends StatefulWidget {
  ReputationShopScreen({Key key}) : super(key: key);

  @override
  _ReputationShopScreenState createState() => _ReputationShopScreenState();
}

class _ReputationShopScreenState extends State<ReputationShopScreen> {
  TextEditingController _controller = TextEditingController();
  String a = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    PreferredSize(
                      child: SliverAppBar(
                        floating: true,
                        pinned: true,
                        // snap: true,
                        elevation: 0,
                        primary: false,
                        backgroundColor: FColors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            child: Column(
                              children: [
                                ShopBanner(),
                                HeaderStore(),
                              ],
                            ),
                          ),
                          collapseMode: CollapseMode.pin,
                        ),
                        toolbarHeight:
                            MediaQuery.of(context).size.width / 2 + 144,
                        bottom: PreferredSize(
                          child: Container(
                            color: FColors.grey1,
                            child: TabBar(
                              indicatorColor: SkinColor.primary,
                              labelColor: FColors.grey6,
                              unselectedLabelColor: SkinColor.primary,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(child: FText("Thông tin")),
                                Tab(child: FText("Chỉ đường")),
                                Tab(child: FText("Đánh giá")),
                              ],
                            ),
                          ),
                          preferredSize: Size.fromHeight(48),
                        ),
                      ),
                      preferredSize: Size.fromHeight(kToolbarHeight),
                    )
                  ];
                },
                body: Container(
                  child: TabBarView(
                    children: [
                      Container(
                        child: ShopDetails(),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: FBoundingBox(
                          size: FBoxSize.auto_square,
                          child: Image.asset(
                            'lib/G-Store/Assets/Map.png',
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            FTextFormField(
                              size: FTextFormFieldSize.size56,
                              label: "This is Test",
                              value: a,
                              controller: _controller,
                              onChanged: (value) {
                                setState(() {
                                  a = value;
                                });
                              },
                            ),
                            FSpacer.space24px,
                            FListTitle(
                              height: 163,
                              avatar: FBoundingBox(
                                size: FBoxSize.auto_square,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: FText("4.4"),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FIcon(icon: FOutlinedIcons.star),
                                          FIcon(icon: FOutlinedIcons.star),
                                          FIcon(icon: FOutlinedIcons.star),
                                          FIcon(icon: FOutlinedIcons.star),
                                          FIcon(icon: FOutlinedIcons.star),
                                        ],
                                      ),
                                      Center(
                                        child: FText("80 lượt đánh giá"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              titleItem: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Slider(
                                        value: 20,
                                        onChanged: null,
                                        min: 0,
                                        max: 100,
                                      ),
                                      FText('5 sao')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Slider(
                                        value: 20,
                                        onChanged: null,
                                        min: 0,
                                        max: 100,
                                      ),
                                      FText('4 sao')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Slider(
                                          value: 20,
                                          onChanged: null,
                                          min: 0,
                                          max: 100),
                                      FText('3 sao')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Slider(
                                          value: 20,
                                          onChanged: null,
                                          min: 0,
                                          max: 100),
                                      FText('2 sao')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Slider(
                                          value: 20,
                                          onChanged: null,
                                          min: 0,
                                          max: 100),
                                      FText('1 sao')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
