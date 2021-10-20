import 'dart:async';

import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static final storage = new FlutterSecureStorage();
  checkToken() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('home_screen');
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('login_screen');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    // precacheImage(
    //     new AssetS('lib/FIS.SYS/Assets/images/NotFound.svg'), context);
    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder,
            'lib/FIS.SYS/Assets/images/NotFound.svg'),
        null);
    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder,
            'lib/FIS.SYS/Assets/images/Building.svg'),
        null);
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
