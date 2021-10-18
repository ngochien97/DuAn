import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Students/StudentItem.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'F.Utils/SentryUtils.dart';
import 'F.Utils/Utils.dart';
// import 'FIS.SYS/Core/CacheService.dart';
import 'FIS.SYS/Core/bloc/CoreBlocObserver.dart';
import 'FIS.SYS/Core/routes.dart';
import 'FIS.SYS/Core/snackbar_bloc/SnackBarBloc.dart';
import 'FIS.SYS/Core/snackbar_bloc/TopSnackBar.dart';
import 'FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'FIS.SYS/Modules/Assessment/Models/GradesItem.dart';
import 'FIS.SYS/Modules/GeneralStat/Provider/GeneralStat.dart';
import 'FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'FIS.SYS/Modules/Presentation/Providers/PresentProvider.dart';
import 'FIS.SYS/Modules/Presentation/Providers/PresentationHistoryProvider.dart';
import 'FIS.SYS/Modules/Presentation/Providers/PresentationProvider.dart';
import 'FIS.SYS/Modules/Presentation/Providers/ScanProvider.dart';
import 'FIS.SYS/Modules/Students/StudentsModel.dart';
import 'FIS.SYS/Modules/TakerGroups/Provider/TakerGroupCloseProvider.dart';
import 'FIS.SYS/Modules/TakerGroups/Provider/TakerGroupDeletedProvider.dart';
import 'FIS.SYS/Modules/TakerGroups/Provider/TakerGroupProvider.dart';
import 'FIS.SYS/Modules/TakerGroups/Provider/TestTakerProvider.dart';
import 'FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'FIS.SYS/Modules/User/Provider/auth.dart';
import 'Khao_thi_GV/RouteNames.dart';
import 'Khao_thi_GV/routes.dart';
import 'locator.dart';

// Run the whole app in a zone to capture all uncaught errors.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(StudentItemAdapter());
  Hive.registerAdapter(StudentsModelAdapter());
  Hive.registerAdapter(HistoryNotificationItemAdapter());
  Hive.registerAdapter(GradesItemAdapter());
  setupLocator();
  Bloc.observer = CoreBlocObserver();

  runZoned(
    () => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TakerGroupProvider()),
        ChangeNotifierProvider(create: (context) => TakerGroupCloseProvider()),
        ChangeNotifierProvider(
            create: (context) => TakerGroupDeletedProvider()),
        ChangeNotifierProvider(create: (context) => GeneralStat()),
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => TestTakerProvider()),
        ChangeNotifierProvider(create: (context) => ScanProvider()),
        ChangeNotifierProvider(create: (context) => PresentationProvider()),
        ChangeNotifierProvider(
            create: (context) => PresentationHistoryProvider()),
        ChangeNotifierProvider(create: (context) => PresentProvider()),
      ],
      child: MyApp(),
    )),
    onError: (Object error, StackTrace stackTrace) async {
      try {
        if (Utils.ENVIRONMENT == 'development') {
          return;
        }
        final event = await getSentryEnvEvent(error, stackTrace);
        await SentryUtils.sentry.capture(event: event);
      } on Exception catch (_) {
        developer.log('Original error: $error');
      }
    },
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  List<BlocListener> _getBlocListener(context) => [
        BlocListener<SnackBarBloc, SnackbarState>(
            listener: _mapListenerSnackbarState),
      ];
  void _mapListenerSnackbarState(BuildContext context, SnackbarState state) {
    if (state is ShowSnackBarState) {
      TopSnackBar(
        title: state.content,
        type: state.type,
      ).showWithNavigator(
          CoreRoutes.instance.navigatorKey.currentState, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SnackBarBloc>(
          create: (_) => locator<SnackBarBloc>(),
        ),
        BlocProvider<NotificationBloc>(
          create: (_) => locator<NotificationBloc>(),
        ),
        BlocProvider<ClassRubricBloc>(
          create: (BuildContext context) => locator<ClassRubricBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo App',
        initialRoute: RouteNames.SPLASH,
        navigatorKey: CoreRoutes.instance.navigatorKey,
        onGenerateRoute: Routes.generateRoute,
        builder: (context, widget) {
          return MultiBlocListener(
            listeners: _getBlocListener(context),
            child: widget,
          );
        },
      ),
    );
  }
}
