import 'package:Framework/FIS.SYS/Modules/Utils/NavigationService.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/G-Store/Screens/Categories.dart';
import 'package:Framework/G-Store/Screens/SearchMap.dart';
import 'package:Framework/G-Store/Screens/SplashScreen.dart';
import 'package:Framework/QR_code/Login.dart';
import 'package:flutter/material.dart';
import 'package:Framework/G-Store/screen.dart';
// import 'package:Framework/FDA/screens.dart';
import 'package:Framework/FDA/Providers/FileProvider.dart';
import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:Framework/FDA/routes.dart';

GetIt locator = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => CompanyProvider()),
        ChangeNotifierProvider(create: (ctx) => FileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FDA.Thue',
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      home: LoginQR(),
      routes: routes,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  1.0), // default textSize as size app set, Not affected by the size of the phone.
        );
      },
    );
  }
}
