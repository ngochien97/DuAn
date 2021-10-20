import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FDA/Screens/SignInScreen.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Modules/State/NotYetSupported.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../FDA/Providers/UserProvider.dart';

class UserLogin extends StatefulWidget {
  final GlobalKey loginKey;

  UserLogin({Key key, this.loginKey}) : super(key: key);

  // final String title = 'Launch Url';

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  static final storage = new FlutterSecureStorage();
  UserItem userItem = new UserItem(email: "", password: "", isRemember: false);
  bool obscureText = true;
  bool isLoading = false;
  UserDA userDA = UserDA();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();

  String email = '';
  String password = '';

  String emailMessage;
  String passwordMessage;

  bool emailValidate = true;
  bool passwordValidate = true;

  @override
  void didChangeDependencies() {
    validateEmail();
    validatePassword();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, authprovider, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SvgPicture.asset(
                      'lib/FIS.SYS/Assets/images/Logo.svg',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: FTextFormField(
                    controller: _controllerEmail,
                    message: emailMessage,
                    validate: emailValidate,
                    label: 'Email đăng nhập',
                    size: FTextFormFieldSize.size56,
                    value: email,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                        userItem.email = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: FTextFormField(
                    controller: _controllerPass,
                    message: passwordMessage,
                    validate: passwordValidate,
                    label: 'Mật khẩu',
                    size: FTextFormFieldSize.size56,
                    rightIcon: obscureText
                        ? FFilledIcons.eye
                        : FFilledIcons.eye_invisible,
                    value: password,
                    obscureText: obscureText,
                    onRightIconPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                        userItem.password = value;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: FButton(
                        title: 'Quên mật khẩu?',
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: FColors.green6,
                        onPressed: () {
                          // _launchInBrowser(_launchUrl);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotYetSupport()));
                        },
                        backgroundColor: FColors.grey2,
                        size: FButtonSize.size24,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: FButton(
                    title: 'Đăng nhập',
                    color: FColors.grey1,
                    backgroundColor: FColors.green6,
                    size: FButtonSize.size48,
                    block: true,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setLoginMessage();
                      validateEmail();
                      validatePassword();
                      setState(() {
                        isLoading = true;
                      });
                      if (emailValidate == false && passwordValidate == false) {
                        try {
                          // UserDA.login(userItem, context);
                          var data = await userDA.login(userItem);
                          if (data.statusCode == 200) {
                            storage.write(
                                key: "token", value: data.userItem.token);
                            // var user = await userDA.getInfo();
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(data.userItem);
                            // if (user.statusCode == 200) {
                            storage.write(key: "email", value: userItem.email);
                            //   Provider.of<UserProvider>(context, listen: false)
                            //       .setUser(user.userItem);
                            // }
                            Navigator.pushReplacementNamed(
                                context, "home_screen");
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            showFSnackBar(
                              context,
                              FSnackBar(
                                position: FlushbarPosition.TOP,
                                backgroundColor: FColors.red6,
                                borderRadius: 8.0,
                                icon: FIcon(
                                  icon: FOutlinedIcons.close_circle,
                                  size: 24,
                                  color: [FColors.grey1],
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                message: FText(
                                  // userItem.email == '' ||
                                  //         userItem.password == ''
                                  //     ? "Vui lòng nhập tài khoản/ mật khẩu!"
                                  //     :
                                  data.message != null
                                      ? data.message
                                      : 'Tên đăng nhập hoặc mật khẩu không đúng. Xin vui lòng thử lại!',
                                  color: FColors.grey1,
                                ),
                              ),
                            );
                          }
                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    isLoading: isLoading,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FText(
                        'Chưa có tài khoản. ',
                        style: FTextStyle.bodyText2,
                        color: FColors.grey6,
                      ),
                      GestureDetector(
                        child: FText(
                          'Đăng ký ngay',
                          style: FTextStyle.bodyText2,
                          color: FColors.green6,
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SignIn()));

                          Navigator.pushNamed(context, 'signin_screen');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void setEmailMessage() {
  //   if (email == '' || email == null) {
  //     setState(() {
  //       emailMessage = "Vui lòng nhập tài khoản";
  //     });
  //   } else {
  //     emailMessage = null;
  //   }
  // }

  // void setPasswordMessage() {
  // if (password == '' || password == null) {
  //   setState(() {
  //     passwordMessage = "Vui lòng nhập mật khẩu";
  //   });
  // } else {
  //   passwordMessage = null;
  // }
  // }

  void setLoginMessage() {
    if (email == '' || email == null) {
      setState(() {
        emailMessage = "Vui lòng nhập tài khoản";
      });
    } else {
      setState(() {
        emailMessage = null;
      });
    }

    if (password == '' || password == null) {
      setState(() {
        passwordMessage = "Vui lòng nhập mật khẩu";
      });
    } else {
      setState(() {
        passwordMessage = null;
      });
    }
  }

  void validateEmail() {
    if (emailMessage == '' || emailMessage == null) {
      setState(() {
        emailValidate = false;
      });
    } else {
      setState(() {
        emailValidate = true;
      });
    }
  }

  void validatePassword() {
    if (passwordMessage == '' || passwordMessage == null) {
      setState(() {
        passwordValidate = false;
      });
    } else {
      setState(() {
        passwordValidate = true;
      });
    }
  }
}
