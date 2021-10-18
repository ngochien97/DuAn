import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassBloc.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/HistoryNotifications.dart';

import '../FIS.SYS/Core/routes.dart';
import '../FIS.SYS/Modules/Presentation/Actions/ListTopic.dart';
import '../FIS.SYS/Modules/TakerGroups/ClassInfomation.dart';
import '../FIS.SYS/Modules/TakerGroups/TakerGroup.dart';
import '../Khao_thi_GV/RouteNames.dart';
import '../Khao_thi_GV/Screens/M.0.0_Splash.dart';
import '../Khao_thi_GV/Screens/M.0.2_Version.dart';
import '../Khao_thi_GV/Screens/M.1.0_Home.dart';
import '../Khao_thi_GV/Screens/M.4.1.2_History.dart';
import '../Khao_thi_GV/Screens/M.5.1_DonVi.dart';
import 'Screens/M.0.1_Login.dart';
import 'Screens/M.2.1_Danh_sach_rubric.dart';
import 'Screens/M.3.5_Chi_tiet_kip_thi.dart';
import 'Screens/M.5.3_Settings.dart';

class Routes extends CoreRoutes {
  factory Routes() => CoreRoutes.instance;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.SPLASH:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case CoreRouteNames.LOGIN_SCREEN:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteNames.VERSION:
        final bool changeVer = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => VersionScreen(changeVer: changeVer),
        );
      case RouteNames.HOME:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RouteNames.TAKERGROUPDETAIL:
        final TakerGroup takerGroup = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => TakerDetailScreen(takerGroup),
        );
      case RouteNames.COMPANY_INFOR:
        return MaterialPageRoute(
          builder: (context) => UnitInforScreen(),
        );
      case RouteNames.SETTINGS:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
      case RouteNames.PRESENTATION:
        final ClassInfomation classInfo = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ListTopicScreen(classInfo),
        );
      case RouteNames.PRESENTATION_HISTORY:
        final int classId = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => HistoryScreen(classId),
        );
      case RouteNames.HISTORY_NOTIFICATIONS:
        return MaterialPageRoute(
          builder: (context) => HistoryNotifications(),
        );
      case RouteNames.LIST_RUBRIC_OF_CLASS:
        final ClassRubricItem classInfo = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (BuildContext context) =>
                      RubricInClassBloc(classInfo),
                  child: ListRubric(),
                ));
      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
}
