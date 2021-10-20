import 'dart:async';

import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<bool> isFirstTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var isFirstTime = prefs.getBool('first_time');
  //   if (isFirstTime != null && !isFirstTime) {
  //     prefs.setBool('first_time', false);
  //     return false;
  //   } else {
  //     prefs.setBool('first_time', false);
  //     return true;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('login_screen');
      // isFirstTime().then((isFirstTime) {
      //    Navigator.of(context).pushReplacementNamed('login_screen');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var assetsImage =
    //     'assets/icons/LogoGStore.svg'; //<- Creates an object that fetches an image.
    // var image = SvgPicture.asset(
    //   assetsImage,
    //   width: 81,
    //   height: 81,
    // ); //<- Creates a widget that displays an image.

    return Scaffold(
      backgroundColor: FColors.grey1,
      body: FState(
        picture: Image.asset(
          'lib/FIS.SYS/Assets/GIF/Splash.gif',
        ),
        noticeText: 'Dễ dàng Scan và đồng bộ hóa đơn từ điện thoại của bạn',
        noticeTextStyle: FTextStyle.titleModules3,
        button: false,
        iconButton: false,
        backgroundColor: FColors.grey1,
      ),
    );
  }
}
