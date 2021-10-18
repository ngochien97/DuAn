import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../F.Utils/ScreenUtils.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Core/routes.dart';
import '../../FIS.SYS/Modules/User/UserDA.dart';
import '../../FIS.SYS/Styles/Colors.dart';
import '../RouteNames.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserDA userDA = UserDA();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    Timer.periodic(Duration(minutes: 5), (Timer t) async {
      await userDA.refreshToken();
    });

    Timer(
      Duration(seconds: 3),
      () async {
        try {
          final token = await storage.read(key: 'authen_access_token');
          final subscription = await storage.read(key: 'subscriptionActive');
          final isAuth = token != null;
          if (!isAuth) {
            await CoreRoutes.instance
                .navigateAndReplace(CoreRouteNames.LOGIN_SCREEN);
          } else {
            if (subscription != null) {
              await CoreRoutes.instance.navigateAndReplace(RouteNames.HOME);
            } else {
              await CoreRoutes.instance.navigateAndReplace(RouteNames.VERSION);
            }
          }
        } catch (e) {
          await CoreRoutes.instance
              .navigateAndReplace(CoreRouteNames.LOGIN_SCREEN);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: FColors.grey1,
      body: FState(
        picture: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.16),
          child: SvgPicture.asset(
            'lib/FIS.SYS/Assets/images/logo_khaothi.svg',
            fit: BoxFit.fitWidth,
          ),
        ),
        button: false,
        iconButton: false,
        backgroundColor: FColors.grey1,
      ),
    );
  }
}
