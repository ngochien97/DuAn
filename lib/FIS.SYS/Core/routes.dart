import 'package:flutter/cupertino.dart';

class CoreRouteNames {
  // ignore: constant_identifier_names
  static const String LOGIN_SCREEN = '/LOGIN_SCREEN';
}

class CoreRoutes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory CoreRoutes() => _instance;

  CoreRoutes._internal();

  static final CoreRoutes _instance = CoreRoutes._internal();

  static CoreRoutes get instance => _instance;

  String curentRoutes = '';

  Future<dynamic> navigateTo(String routeName, {Object arguments}) async =>
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(String routeName,
          {Object arguments}) async =>
      navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  Future<dynamic> navigateAndReplace(String routeName,
          {Object arguments}) async =>
      navigatorKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);

  dynamic pop({dynamic result}) => navigatorKey.currentState.pop(result);
}
