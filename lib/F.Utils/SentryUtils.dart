import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:sentry/sentry.dart';

import 'Utils.dart';

class SentryUtils {
  static final SentryClient sentry = SentryClient(
      dsn: 'https://bd4a9b49d3104ee082d25f12576181f7@sentry.xcbt.online/7');
}

Future<Event> getSentryEnvEvent(dynamic exception, dynamic stackTrace) async {
  final deviceInfo = DeviceInfoPlugin();
  final packageInfo = await Utils.getPackageInfo();

  /// return Event with IOS extra information to send it to Sentry
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    return Event(
      release: packageInfo.version,
      environment: Utils.ENVIRONMENT, // replace it as it's desired
      extra: <String, dynamic>{
        'name': iosDeviceInfo.name,
        'model': iosDeviceInfo.model,
        'systemName': iosDeviceInfo.systemName,
        'systemVersion': iosDeviceInfo.systemVersion,
        'localizedModel': iosDeviceInfo.localizedModel,
        'utsname': iosDeviceInfo.utsname.sysname,
        'identifierForVendor': iosDeviceInfo.identifierForVendor,
        'isPhysicalDevice': iosDeviceInfo.isPhysicalDevice,
        'buildNumber': packageInfo.buildNumber,
      },
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// return Event with Andriod extra information to send it to Sentry
  if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    return Event(
      release: packageInfo.version,
      environment: 'production', // replace it as it's desired
      extra: <String, dynamic>{
        'type': androidDeviceInfo.type,
        'model': androidDeviceInfo.model,
        'device': androidDeviceInfo.device,
        'id': androidDeviceInfo.id,
        'androidId': androidDeviceInfo.androidId,
        'brand': androidDeviceInfo.brand,
        'display': androidDeviceInfo.display,
        'hardware': androidDeviceInfo.hardware,
        'manufacturer': androidDeviceInfo.manufacturer,
        'product': androidDeviceInfo.product,
        'version': androidDeviceInfo.version.release,
        'supported32BitAbis': androidDeviceInfo.supported32BitAbis,
        'supported64BitAbis': androidDeviceInfo.supported64BitAbis,
        'supportedAbis': androidDeviceInfo.supportedAbis,
        'buildNumber': packageInfo.buildNumber,
      },
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Return standard Error in case of non-specifed paltform
  ///
  /// if there is no detected platform,
  /// just return a normal event with no extra information
  return Event(
    release: '0.0.2',
    environment: 'production',
    exception: exception,
    stackTrace: stackTrace,
  );
}
