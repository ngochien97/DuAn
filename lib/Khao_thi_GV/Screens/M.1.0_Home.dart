import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/MQTTClientWrapper.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Actions/ExamManagement.dart';
// import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationState.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.2.0_Danh_sach_lop.dart';
import 'package:provider/provider.dart';

import '../../F.Utils/LayoutContainWidgetKeepAlive.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/GeneralStat/Actions/StudentStat.dart';
import '../../FIS.SYS/Modules/GeneralStat/Actions/TurnStat.dart';
import '../../FIS.SYS/Modules/GeneralStat/Provider/GeneralStat.dart';
import '../../FIS.SYS/Modules/Presentation/Actions/ListClass.dart';
import '../../FIS.SYS/Modules/TakerGroups/DA/TakerGroupDA.dart';
import '../../FIS.SYS/Modules/User/UserItem.dart';
import '../../FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/Icons.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';
// import 'M.2.0_DanhGia.dart';
import '../../locator.dart';
import 'M.5.0_TaiKhoan.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {
        'screen': LayoutContainWidgetKeepAlive(child: HomeBody()),
        'title': 'Trang chủ',
        'icon': FFilledIcons.home,
      },
      {
        'screen': AppraiseScreen(),
        //  MultiBlocProvider(
        // providers: [
        //   BlocProvider<ClassRubricBloc>(
        //     create: (BuildContext context) => locator<ClassRubricBloc>(),
        //   ),
        // ],
        // child: AppraiseScreen(),
        // ),
        'title': 'Đánh giá',
        'icon': FOutlinedIcons.edit,
      },
      {
        'screen': ExamManagement(),
        'title': 'Quản lý thi',
        'icon': FOutlinedIcons.document,
      },
      {
        'screen': PresentScreen(),
        'title': 'Trình chiếu',
        'icon': FFilledIcons.video_camera,
      },
      {
        'screen': InforScreen(),
        'title': 'Tài khoản',
        'icon': FOutlinedIcons.user,
      },
    ];
    return Scaffold(
      body: items[currentIndex]['screen'],
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

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String userName = '';
  TakerGroupDA takerGroupDA = TakerGroupDA();

  void init() {
    final storage = FlutterSecureStorage();
    storage.read(key: 'userInfo').then((data) async {
      if (data != null) {
        final subscription = await storage.read(key: 'subscriptionActive');

        final user = UserItem.fromJson(json.decode(data));
        await locator<MQTTClientWrapper>().prepareMqttClient();
        locator<MQTTClientWrapper>().subscribeToTopic(
            '$subscription/${user.companyCode}/${user.id}/TEST-TAKER-GROUP');

        setState(() {
          userName = user.fullName;
        });
        if (Provider.of<GeneralStat>(context, listen: false).getStats != null &&
            Provider.of<GeneralStat>(context, listen: false).getSummaryStat !=
                null) {
          return;
        } else {
          takerGroupDA.getStat().then((data) {
            Provider.of<GeneralStat>(context, listen: false)
                .setStatsData(data.stats);
            Provider.of<GeneralStat>(context, listen: false)
                .setSummaryStatData(data.summary);
          });
        }
      }
      locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: FColors.grey2,
        appBar: FAppBar(
          headerLead: Container(
            width: 48,
          ),
          backgroundColor: SkinColor.primary,
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Xin chào, $userName',
              style: FTextStyle.titleModules3,
              color: FColors.grey1,
            ),
          ),
          headerActions: [
            BlocConsumer<NotificationBloc, NotificationState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HistoryNotificationsState) {
                  var totalread = state.histories
                      .where((element) => element.status == 0)
                      .length;
                  if (totalread > 0)
                    return Badge(
                      badgeContent: Text('${totalread}'),
                      position: BadgePosition.topEnd(top: 0, end: 3),
                      child: FIconButton(
                        icon: FOutlinedIcons.bell,
                        backgroundColor: FColors.transparent,
                        size: FIconButtonSize.size48,
                        onPressed: () {
                          CoreRoutes.instance
                              .navigateTo(RouteNames.HISTORY_NOTIFICATIONS);
                        },
                      ),
                    );
                  return FIconButton(
                      icon: FOutlinedIcons.bell,
                      backgroundColor: FColors.transparent,
                      size: FIconButtonSize.size48,
                      onPressed: () {
                        CoreRoutes.instance
                            .navigateTo(RouteNames.HISTORY_NOTIFICATIONS);
                      });
                }
                return FIconButton(
                    icon: FOutlinedIcons.bell,
                    backgroundColor: FColors.transparent,
                    size: FIconButtonSize.size48,
                    onPressed: () {
                      CoreRoutes.instance
                          .navigateTo(RouteNames.HISTORY_NOTIFICATIONS);
                    });
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await takerGroupDA.getStat().then((data) {
              Provider.of<GeneralStat>(context, listen: false)
                  .setStatsData(data.stats);
              Provider.of<GeneralStat>(context, listen: false)
                  .setSummaryStatData(data.summary);
            });
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: <Widget>[
                  StudentStat(),
                  FSpacer.space16px,
                  TurnStat(),
                ],
              ),
            ),
          ),
        ),
      );
}
