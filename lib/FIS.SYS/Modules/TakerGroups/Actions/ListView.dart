import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';

import '../../../../F.Utils/LayoutContainWidgetKeepAlive.dart';
import '../../../Components/AppBar.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../../../Styles/Typographies.dart';
import '../../User/UserItem.dart';
import '../Provider/TakerGroupCloseProvider.dart';
import '../Provider/TakerGroupDeletedProvider.dart';
import '../Provider/TakerGroupProvider.dart';
import 'Search.dart';
import 'TabView.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen>
    with SingleTickerProviderStateMixin {
  bool isShowGroupDeleted = false;
  TabController _tabController;

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Kíp thi'),
    Tab(text: 'Đã đóng thi'),
  ];

  @override
  void initState() {
    final storage = FlutterSecureStorage();
    storage.read(key: 'userInfo').then((data) {
      final userStore = UserItem.fromJson(json.decode(data));
      if (userStore.isAdmin == true || userStore.isManager == true) {
        setState(() {
          myTabs = <Tab>[
            Tab(text: 'Kíp thi'),
            Tab(text: 'Đã đóng thi'),
            Tab(text: 'Kíp thi đã xóa')
          ];
          isShowGroupDeleted = true;
        });
      }
      _tabController = TabController(vsync: this, length: myTabs.length);
      _tabController.addListener(() {
        switch (_tabController.index) {
          case 0:
            CoreRoutes.instance.curentRoutes = RouteNames.TEST_TAKER;
            break;
          case 1:
            CoreRoutes.instance.curentRoutes = RouteNames.TEST_TAKER_CLOSE;
            break;
          case 2:
            CoreRoutes.instance.curentRoutes = RouteNames.TEST_TAKER_DELETE;
            break;
          default:
        }
      });
    });
    CoreRoutes.instance.curentRoutes = RouteNames.TEST_TAKER;
    super.initState();
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: FColors.grey2,
          appBar: FAppBar(
            headerLead: FIconButton(
              icon: FOutlinedIcons.left,
              backgroundColor: FColors.transparent,
              color: FColors.grey9,
              size: FIconButtonSize.size40,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            brightness: Brightness.light,
            headerCenter: Container(
              alignment: Alignment.center,
              child: FText(
                'Trình quản lý thi',
                style: FTextStyle.titleModules3,
              ),
            ),
            headerActions: <Widget>[
              FIconButton(
                icon: FOutlinedIcons.search,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchView()));
                },
                backgroundColor: FColors.transparent,
                color: FColors.grey9,
              )
            ],
            bottom: Column(
              children: [
                FDivider(),
                TabBar(
                  indicatorColor: SkinColor.primary,
                  labelColor: SkinColor.primary,
                  labelStyle:
                      CustomFont.regular14_22.copyWith(color: FColors.grey7),
                  unselectedLabelStyle:
                      CustomFont.regular14_22.copyWith(color: FColors.grey7),
                  unselectedLabelColor: FColors.grey7,
                  tabs: myTabs,
                  controller: _tabController,
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              LayoutContainWidgetKeepAlive(
                child: TabView<TakerGroupProvider>(),
              ),
              LayoutContainWidgetKeepAlive(
                child: TabView<TakerGroupCloseProvider>(),
              ),
              if (isShowGroupDeleted)
                LayoutContainWidgetKeepAlive(
                  child: TabView<TakerGroupDeletedProvider>(),
                ),

              // if (isShowGroupDeleted) Tab1<TakerGroupDeletedProvider>()
            ],
          ),
        ),
      );
}
