import 'package:Framework/FDA/HomeScreen.dart';
import 'package:Framework/FDA/Login/Login_Index.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FDA/Providers/CompanyProvider.dart';
import 'package:Framework/FDA/Providers/DocumentProvider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Framework/FDA/routes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => CompanyProvider()),
        ChangeNotifierProvider(create: (ctx) => DocumentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => MaterialApp(
        title: 'FDA.Thue',
        debugShowCheckedModeBanner: false,
        home: authProvider.isAuth ? HomeScreen() : LoginIndex(),
        routes: routes,
      ),
    );
  }
}
