// ignore: file_names
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';

import '../../F.Utils/Utils.dart' as utils;
import 'BaseResponse.dart';
import 'Config.dart';
import 'routes.dart';

class BaseDA {
  static const storage = FlutterSecureStorage();
  static const urlBase = ConfigAPI.baseUrl;

  Future<void> deleteSubscription() async {
    await storage.delete(key: 'authen_access_token');
    await storage.delete(key: 'subscriptionActive');
    await storage.delete(key: 'subscriptions');
  }

  Future<BaseResponse> get(String url, BaseResponse baseResponse) async {
    try {
      final authenAccessToken =
          'Bearer ${await storage.read(key: 'authen_access_token')}';
      final headers = <String, String>{
        'Authorization': authenAccessToken ?? '',
        'xcbt-subscription': await storage.read(key: 'subscriptionActive')
      };
      // ignore: parameter_assignments
      url = urlBase + url;

      for (var i = 0; i < 2; i++) {
        final response = await http.get(url, headers: headers);
        utils.Utils.console(url);
        if (response.statusCode == 200) {
          final jsondata = json.decode(response.body);

          if (jsondata['code'] == 400 &&
              jsondata['message'].toString().contains('Expire')) {
            if (i == 0) {
              await refreshToken();
              continue;
            }
          }

          baseResponse.fromJson(jsondata);

          return baseResponse;
        }
        if (response.statusCode == 401) {
          await deleteSubscription();
          await CoreRoutes.instance
              .navigateAndRemove(CoreRouteNames.LOGIN_SCREEN);
        }
        baseResponse.code = response.statusCode;
        return baseResponse;
      }
    } catch (e) {
      utils.Utils.console(e);
    }
    baseResponse.code = -1;
    return baseResponse;
  }

  Future<BaseResponse> post(String url, BaseResponse baseResponse) async {
    try {
      final authenAccessToken =
          'Bearer ${await storage.read(key: 'authen_access_token')}';
      final headers = <String, String>{
        'Authorization': authenAccessToken ?? '',
        'xcbt-subscription': await storage.read(key: 'subscriptionActive')
      };
      // ignore: parameter_assignments
      url = urlBase + url;
      for (var i = 0; i < 2; i++) {
        final response = await http.post(url, headers: headers);
        utils.Utils.console(url);
        utils.Utils.console(response.body);
        if (response.statusCode == 200) {
          final jsondata = json.decode(response.body);
          utils.Utils.console(url);
          utils.Utils.console(jsondata);
          if (jsondata['code'] == 400 &&
              jsondata['message'].toString().contains('Expire')) {
            if (i == 0) {
              await refreshToken();
              continue;
            }
          }
          baseResponse.fromJson(jsondata);

          return baseResponse;
        }
        if (response.statusCode == 401) {
          await deleteSubscription();
          await CoreRoutes.instance
              .navigateAndRemove(CoreRouteNames.LOGIN_SCREEN);
        }
        baseResponse.code = response.statusCode;
        return baseResponse;
      }

      return baseResponse;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      utils.Utils.console(e);
    }
    return baseResponse;
  }

  Future<BaseResponse> postData(
      String url, String obj, BaseResponse baseResponse) async {
    try {
      final authenAccessToken =
          'Bearer ${await storage.read(key: 'authen_access_token')}';
      final headers = <String, String>{
        'Authorization': authenAccessToken ?? '',
        'xcbt-subscription': await storage.read(key: 'subscriptionActive'),
        'Content-type': 'application/json',
      };
      // ignore: parameter_assignments
      url = urlBase + url;
      for (var i = 0; i < 2; i++) {
        final response = await http.post(url, body: obj, headers: headers);
        utils.Utils.console(url);
        utils.Utils.console(response.body);
        if (response.statusCode == 200) {
          final jsondata = json.decode(response.body);
          utils.Utils.console(url);
          utils.Utils.console(jsondata);
          if (jsondata['code'] == 400 &&
              jsondata['message'].toString().contains('Expire')) {
            if (i == 0) {
              await refreshToken();
              continue;
            }
          }
          baseResponse.fromJson(jsondata);

          return baseResponse;
        }
        if (response.statusCode == 401) {
          await deleteSubscription();
          await CoreRoutes.instance
              .navigateAndRemove(CoreRouteNames.LOGIN_SCREEN);
        }
        baseResponse.code = response.statusCode;
        return baseResponse;
      }

      return null;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      utils.Utils.console(e);
    }
    return null;
  }

  Future<bool> refreshToken() async {
    final authorizationEndpoint = Uri.parse('${Config.urlLogin}token');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authen_refresh_token');

    if (token == null || token == '') {
      return false;
    }

    final credentials = oauth2.Credentials('',
        tokenEndpoint: authorizationEndpoint, refreshToken: token);
    try {
      final client =
          await oauth2.Client(credentials, identifier: Config.identifier)
              .refreshCredentials();
      await storage.write(
          key: 'authen_access_token', value: client.credentials.accessToken);
      await storage.write(
          key: 'authen_refresh_token', value: client.credentials.refreshToken);
      utils.Utils.console('refresh success');
      return true;
    } on AuthorizationException {
      await storage.delete(key: 'authen_refresh_token');
      await storage.delete(key: 'authen_access_token');
      return false;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }

  Future<BaseResponse> delete(String url, BaseResponse baseResponse) async {
    try {
      final authenAccessToken =
          'Bearer ${await storage.read(key: 'authen_access_token')}';
      final headers = <String, String>{
        'Authorization': authenAccessToken ?? '',
        'xcbt-subscription': await storage.read(key: 'subscriptionActive')
      };
      // ignore: parameter_assignments
      url = urlBase + url;
      for (var i = 0; i < 2; i++) {
        final response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          final jsondata = json.decode(response.body);
          utils.Utils.console(url);
          utils.Utils.console(jsondata);
          if (jsondata['code'] == 400 &&
              jsondata['message'].toString().contains('Expire')) {
            if (i == 0) {
              await refreshToken();
              continue;
            }
          }
          baseResponse.fromJson(jsondata);

          return baseResponse;
        }
        if (response.statusCode == 401) {
          await deleteSubscription();
          await CoreRoutes.instance
              .navigateAndRemove(CoreRouteNames.LOGIN_SCREEN);
        }
        baseResponse.code = response.statusCode;
        return baseResponse;
      }

      return null;
    } catch (e) {
      utils.Utils.console(e);
    }
    return null;
  }
}
