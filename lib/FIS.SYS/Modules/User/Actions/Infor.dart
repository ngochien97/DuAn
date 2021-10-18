import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/Config.dart';
import '../../../Core/routes.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';

class UserInfor extends StatefulWidget {
  @override
  _UserInforState createState() => _UserInforState();
}

class _UserInforState extends State<UserInfor> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  FlutterSecureStorage storage = FlutterSecureStorage();
  bool isAP3 = false;

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> logout() async {
    final token = await storage.read(key: 'authen_access_token');
    final url = '${Config.urlLogin}logout';
    final body = "{refresh_token:'$token', client_id: '${Config.identifier}'}";
    await http.post(url, body: body);
    await storage.delete(key: 'authen_access_token');
    await storage.delete(key: 'subscriptionActive');
    await storage.delete(key: 'subscriptions');
    await CoreRoutes.instance.navigateAndRemove(CoreRouteNames.LOGIN_SCREEN);
  }

  Future<void> getSubscriptions() async {
    final subscriptions = await storage.read(key: 'subscriptions');
    if (subscriptions != null && subscriptions.split(',').length > 1) {
      setState(() {
        isAP3 = true;
      });
    }
  }

  @override
  void initState() {
    _initPackageInfo();
    getSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          FListTitle(
            onTap: () => CoreRoutes.instance.navigateTo(RouteNames.SETTINGS),
            round: false,
            dividerIndent: true,
            avatar: FBoundingBox(
              backgroundColor: FColors.grey5,
              size: FBoxSize.size32x32,
              type: FBoundingBoxType.circle,
              child: FIcon(
                icon: FFilledIcons.setting,
                color: const <Color>[FColors.grey1],
                size: 16,
              ),
            ),
            title: FText(
              'Cài đặt',
              style: FTextStyle.titleModules6,
            ),
            action: [
              FIcon(
                icon: FOutlinedIcons.right,
                size: 16,
                color: const <Color>[FColors.grey7],
              ),
            ],
          ),
          if (isAP3)
            FListTitle(
              onTap: () => CoreRoutes.instance
                  .navigateTo(RouteNames.VERSION, arguments: true),
              round: false,
              dividerIndent: true,
              avatar: FBoundingBox(
                backgroundColor: FColors.blue5,
                size: FBoxSize.size32x32,
                type: FBoundingBoxType.circle,
                child: FIcon(
                  icon: FOutlinedIcons.swap_horizontal,
                  color: const <Color>[FColors.grey1],
                  size: 16,
                ),
              ),
              title: FText(
                'Đổi phiên bản sử dụng',
                style: FTextStyle.titleModules6,
              ),
              action: [
                FIcon(
                  icon: FOutlinedIcons.right,
                  size: 16,
                  color: const <Color>[FColors.grey7],
                ),
              ],
            ),
          // FListTitle(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AppraiseScreen(
          //                   allowBack: true,
          //                 )));
          //   },
          //   round: false,
          //   dividerIndent: true,
          //   avatar: FBoundingBox(
          //     backgroundColor: FColors.geek_blue5,
          //     size: FBoxSize.size32x32,
          //     type: FBoundingBoxType.circle,
          //     child: FIcon(
          //       icon: FOutlinedIcons.document,
          //       color: const <Color>[FColors.grey1],
          //       size: 16,
          //     ),
          //   ),
          //   title: FText(
          //     'Hướng dẫn sử dụng',
          //     style: FTextStyle.titleModules6,
          //   ),
          //   action: [
          //     FIcon(
          //       icon: FOutlinedIcons.right,
          //       size: 16,
          //       color: const <Color>[FColors.grey7],
          //     ),
          //   ],
          // ),
          // FListTitle(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AppraiseScreen(
          //                   allowBack: true,
          //                 )));
          //   },
          //   round: false,
          //   dividerIndent: true,
          //   avatar: FBoundingBox(
          //     backgroundColor: FColors.orange5,
          //     size: FBoxSize.size32x32,
          //     type: FBoundingBoxType.circle,
          //     child: FIcon(
          //       icon: FOutlinedIcons.star,
          //       color: const <Color>[FColors.grey1],
          //       size: 16,
          //     ),
          //   ),
          //   title: FText(
          //     'Đánh giá ứng dụng',
          //     style: FTextStyle.titleModules6,
          //   ),
          //   action: [
          //     FIcon(
          //       icon: FOutlinedIcons.right,
          //       size: 16,
          //       color: const <Color>[FColors.grey7],
          //     ),
          //   ],
          // ),
          FListTitle(
            onTap: () {
              CoreRoutes.instance.navigateTo(RouteNames.COMPANY_INFOR);
            },
            round: false,
            dividerIndent: true,
            avatar: FBoundingBox(
              backgroundColor: FColors.green5,
              size: FBoxSize.size32x32,
              type: FBoundingBoxType.circle,
              child: FIcon(
                icon: FOutlinedIcons.info,
                color: const <Color>[FColors.grey1],
                size: 16,
              ),
            ),
            title: FText(
              'Thông tin đơn vị',
              style: FTextStyle.titleModules6,
            ),
            action: [
              FIcon(
                icon: FOutlinedIcons.right,
                size: 16,
                color: const <Color>[FColors.grey7],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: FListTitle(
              round: false,
              avatar: FBoundingBox(
                backgroundColor: FColors.red5,
                size: FBoxSize.size32x32,
                type: FBoundingBoxType.circle,
                child: FIcon(
                  icon: FOutlinedIcons.logout,
                  size: 16,
                  color: const <Color>[FColors.grey1],
                ),
              ),
              title: FText(
                'Đăng xuất',
                style: FTextStyle.titleModules6,
                color: FColors.red5,
              ),
              onTap: logout,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            alignment: Alignment.center,
            child: FText(
              'Phiên bản ứng dụng : ${_packageInfo.version}(${_packageInfo.buildNumber})',
              style: FTextStyle.titleModules6,
              color: FColors.grey7,
            ),
          )
        ],
      ),
    );
  }
}
