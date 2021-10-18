import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:provider/provider.dart';

import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/Config.dart';
import '../../../Core/routes.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../Provider/auth.dart';
import '../UserDA.dart';

class ActionLogin extends StatefulWidget {
  @override
  _ActionLoginState createState() => _ActionLoginState();
}

class _ActionLoginState extends State<ActionLogin> {
  bool _obsureText = true;
  final passController = TextEditingController();
  final userNameController = TextEditingController();
  UserDA userDA = UserDA();
  bool _isLoading = false;
  final storage = FlutterSecureStorage();
  bool isError = false;
  String messageUserName;
  String messagePassword;
  bool isFocused = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    storage.read(key: 'keep_username').then((value) {
      userNameController.text = value ?? '';
    });

    if (!kReleaseMode) {
      passController.text = 'Abc@123';
    }
  }

  Future _login() async {
    if (_isLoading) {
      return;
    }

    if (passController.text == '' || userNameController.text == '') {
      setState(() {
        isError = true;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });
    //showToast('2', context: context);
    final authorizationEndpoint = Uri.parse('${Config.urlLogin}token');

    // var a = passController.text + userNameController.text;

    final identifier = Config.identifier;

    try {
      final client = await oauth2.resourceOwnerPasswordGrant(
          authorizationEndpoint, userNameController.text, passController.text,
          basicAuth: false, identifier: identifier);

      setState(() {
        _isLoading = false;
      });

      if (client.credentials.accessToken == '' ||
          client.credentials.accessToken == null) {
        setState(() {
          isError = true;
        });
        return;
      }

      await storage.write(key: 'keep_username', value: userNameController.text);

      final decodedToken = JwtDecoder.decode(client.credentials.accessToken);
      final subscriptions = decodedToken['subscriptions'] as List;
      final futures = <Future>[];

      futures.add(storage.write(
          key: 'authen_access_token', value: client.credentials.accessToken));
      futures.add(storage.write(
          key: 'authen_refresh_token', value: client.credentials.refreshToken));
      if (subscriptions.length == 1) {
        futures.add(storage.write(
            key: 'subscriptionActive', value: 'A${subscriptions[0]}'));
        futures.add(storage.write(
            key: 'subscriptions', value: subscriptions.join(',')));

        // get user info

        await Future.wait(futures);

        await Provider.of<Auth>(context, listen: false)
            .setToken(client.credentials.accessToken);
        final user = await userDA.getInfo();
        await storage.write(
            key: 'userInfo', value: json.encode(user.userItem.toJson()));

        await CoreRoutes.instance
            .navigateAndReplace(RouteNames.HOME, arguments: true);
      }
      await CoreRoutes.instance.navigateAndReplace(
        RouteNames.VERSION,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      showFSnackBar(
        context,
        FSnackBar(
          borderRadius: 8,
          icon: FIcon(
            icon: FFilledIcons.close_circle,
            color: const <Color>[FColors.grey1, FColors.red6],
          ),
          message: FText(
            'Thông tin người dùng không hợp lệ',
            color: FColors.grey1,
          ),
          backgroundColor: SkinColor.error,
          margin: EdgeInsets.all(8),
        ),
      );
      setState(() {
        isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          isFocused = false;
        });
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.1,
                        size.height * 0.1, size.width * 0.16, 48),
                    child: SvgPicture.asset(
                      'lib/FIS.SYS/Assets/images/logo_khaothi.svg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: FTextField(
                      size: FTextFieldSize.size48,
                      label: 'Tên tài khoản',
                      controller: userNameController,
                      message: messageUserName,
                      value: userNameController.text,
                      onFocus: (value) {
                        setState(() {
                          isFocused = true;
                          _scrollController.animateTo(0,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease);
                        });
                      },
                      status: messageUserName != null
                          ? FTextFieldStatus.error
                          : FTextFieldStatus.normal,
                      onChanged: (value) {
                        setState(() {
                          messageUserName = null;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: FTextField(
                      size: FTextFieldSize.size48,
                      label: 'Mật khẩu',
                      value: passController.text,
                      onFocus: (value) {
                        setState(() {
                          isFocused = true;
                          _scrollController.animateTo(0,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease);
                        });
                      },
                      rightIcon: _obsureText
                          ? FFilledIcons.eye_invisible
                          : FFilledIcons.eye,
                      obscureText: _obsureText,
                      controller: passController,
                      status: messagePassword != null
                          ? FTextFieldStatus.error
                          : FTextFieldStatus.normal,
                      message: messagePassword,
                      onRightIconPressed: () {
                        setState(() {
                          _obsureText = !_obsureText;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          messagePassword = null;
                        });
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(bottom: 20),
                    child: FText(
                      'Quên mật khẩu',
                      color: FColors.blue6,
                    ),
                  ),
                  FButton(
                    size: FButtonSize.size48,
                    block: true,
                    backgroundColor: SkinColor.primary,
                    isLoading: _isLoading,
                    title: 'Đăng nhập',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        isFocused = false;
                      });
                      if (userNameController.text == '' &&
                          passController.text == '') {
                        setState(() {
                          messageUserName = 'Tên tài khoản không hợp lệ';
                          messagePassword = 'Mật khẩu không hợp lệ';
                        });
                      } else if (userNameController.text == '') {
                        setState(() {
                          messageUserName = 'Tên tài khoản không hợp lệ';
                          messagePassword = null;
                        });
                      } else if (passController.text == '') {
                        setState(() {
                          messageUserName = null;
                          messagePassword = 'Mật khẩu không hợp lệ';
                        });
                      } else if (passController.text.contains(' ')) {
                        setState(() {
                          messagePassword =
                              'Mật khẩu không được chứa khoảng trắng';
                        });
                      } else {
                        userNameController.text =
                            userNameController.text.trimRight();
                        userNameController.text =
                            userNameController.text.trimLeft();
                        setState(() {
                          messageUserName = null;
                          messagePassword = null;
                        });
                        _login();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
