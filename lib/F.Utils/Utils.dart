// ignore: file_names
import 'dart:io';
import 'dart:ui';
import 'package:device_info/device_info.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/SnackBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:package_info/package_info.dart';

class Utils {
  static String _deviceId;
  static PackageInfo _info;

  static Future<String> getDeviceId() async {
    if (_deviceId != null) {
      return _deviceId;
    }
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ??
          'undefined'; // unique ID on iOS
    } else {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId ?? 'undefined'; // unique ID on Android
    }
  }

  static Future<PackageInfo> getPackageInfo() async {
    if (_info != null) {
      return _info;
    }
    final info = await PackageInfo.fromPlatform();
    return info;
  }

  static String connvertNumberToCharAnswer(String char) {
    switch (char) {
      case '1':
        return 'A';
      case '2':
        return 'B';
      case '3':
        return 'C';
      case '4':
        return 'D';
      default:
        return null;
    }
  }

  static void console(dynamic log) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(log);
    }
  }

  static void error(dynamic log) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(log);
    }
  }

  static const ENVIRONMENT =
      String.fromEnvironment('Environment', defaultValue: 'development');

  static void showMessage(String message, Color color, BuildContext context) {
    showFSnackBar(
        context,
        FSnackBar(
          message: FText(
            '$message',
            color: FColors.grey1,
          ),
          borderRadius: 8.0,
          position: FlushbarPosition.TOP,
          backgroundColor: color,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ));
  }
}
