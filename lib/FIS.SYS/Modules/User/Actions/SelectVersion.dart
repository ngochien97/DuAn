import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/routes.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../../GeneralStat/Provider/GeneralStat.dart';
import '../UserDA.dart';

class SelectVersion extends StatefulWidget {
  final bool changeVer;
  const SelectVersion({this.changeVer});
  @override
  _SelectVersionState createState() => _SelectVersionState();
}

class _SelectVersionState extends State<SelectVersion> {
  final storage = FlutterSecureStorage();
  UserDA userDA = UserDA();
  Widget title = Container(
    height: 48,
  );

  Future setSubscription(String subcription) async {
    if (Provider.of<GeneralStat>(context, listen: false).getStats != null ||
        Provider.of<GeneralStat>(context, listen: false).getSummaryStat !=
            null) {
      Provider.of<GeneralStat>(context, listen: false).setStatsData(null);
      Provider.of<GeneralStat>(context, listen: false).setSummaryStatData(null);
    }
    final futures = <Future>[];
    final accessToken = await storage.read(key: 'authen_access_token');
    final decodedToken = JwtDecoder.decode(accessToken);
    final subscriptions = decodedToken['subscriptions'] as List;
    futures.add(
        storage.write(key: 'subscriptions', value: subscriptions.join(',')));

    // get user info

    await Future.wait(futures);
    await storage.write(key: 'subscriptionActive', value: subcription);
    final user = await userDA.getInfo();
    await storage.write(
        key: 'userInfo', value: json.encode(user.userItem.toJson()));

    await CoreRoutes.instance
        .navigateAndRemove(RouteNames.HOME, arguments: true);
  }

  Future<void> changeVersion() async {
    final subscript = await storage.read(key: 'subscriptionActive');
    if (subscript == null || subscript == '') {
      setState(() {
        title = Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: FText(
                'Đăng nhập thành công',
                style: FTextStyle.titleModules1,
              ),
            ),
            FText('Thầy cô vui lòng chọn phiên bản sử dụng:',
                style: FTextStyle.bodyText1, color: FColors.grey7),
          ],
        );
      });
    } else if (subscript == 'AP3') {
      setState(() {
        title = Container(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Thầy cô đang sử dụng ',
                    style:
                        CustomFont.regular16_24.copyWith(color: FColors.grey9)),
                TextSpan(
                    text: 'phiên bản trường',
                    style:
                        CustomFont.regular16_24.copyWith(color: FColors.blue6)),
              ])),
              FText(
                'Bấm vào nút bên dưới để thay đổi phiên bản.',
                style: FTextStyle.titleModules4,
              ),
            ],
          ),
        );
      });
    } else if (subscript == 'AP1') {
      setState(() {
        title = Container(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Thầy cô đang sử dụng ',
                    style:
                        CustomFont.regular16_24.copyWith(color: FColors.grey9)),
                TextSpan(
                    text: 'phiên bản cá nhân',
                    style: CustomFont.regular16_24
                        .copyWith(color: FColors.green6)),
              ])),
              FText(
                'Bấm vào nút bên dưới để thay đổi phiên bản.',
                style: FTextStyle.titleModules4,
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void initState() {
    changeVersion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: FColors.grey1,
      child: Column(
        children: <Widget>[
          widget.changeVer == true
              ? Container()
              : Container(
                  margin: EdgeInsets.fromLTRB(size.width * 0.3, 20,
                      size.width * 0.3, size.height * 0.03),
                  child: SvgPicture.asset(
                    'lib/FIS.SYS/Assets/images/Logo-fpt.svg',
                    fit: BoxFit.contain,
                  ),
                ),
          widget.changeVer == true ? FSpacer.space40px : Container(),
          Container(
            height: 284,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.14),
            child: SvgPicture.asset(
              'lib/FIS.SYS/Assets/images/Teacher-amico.svg',
              fit: BoxFit.contain,
            ),
          ),
          title,
          FSpacer.space24px,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: FButton(
              title: 'Phiên bản trường',
              block: true,
              size: FButtonSize.size48,
              backgroundColor: SkinColor.primary,
              onPressed: () async {
                await setSubscription('AP3');
              },
            ),
          ),
          FSpacer.space24px,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: FButton(
              title: 'Phiên bản cá nhân',
              block: true,
              size: FButtonSize.size48,
              backgroundColor: FColors.green6,
              onPressed: () async {
                await setSubscription('AP1');
              },
            ),
          ),
        ],
      ),
    );
  }
}
