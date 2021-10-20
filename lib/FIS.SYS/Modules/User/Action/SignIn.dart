import 'dart:math';

import 'package:Framework/FDA/Providers/UserProvider.dart';
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
import 'package:Framework/F.Utils/Validate.dart';

import '../../../../FDA/Providers/UserProvider.dart';

class UserSignIn extends StatefulWidget {
  final GlobalKey loginKey;

  UserSignIn({Key key, this.loginKey}) : super(key: key);

  // final String title = 'Launch Url';

  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  static final storage = new FlutterSecureStorage();
  UserItem userItem =
      new UserItem(email: "", password: "", fullName: "", phoneNumber: "");
  bool obscureText = true;
  bool obscureText2 = true;
  bool isLoading = false;
  UserDA userDA = UserDA();
  TextEditingController _controllerFullName = new TextEditingController();
  TextEditingController _controllerPhoneNumber = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  TextEditingController _controllerPass2 = new TextEditingController();

  String fullName = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
  String password2 = '';

  String fullNameMessage;
  String phoneNumberMessage;
  String emailMessage;
  String passwordMessage;
  String passwordMessage2;

  bool fullNameValidate = false;
  bool phoneNumberValidate = false;
  bool emailValidate = false;
  bool passwordValidate = false;
  bool passwordValidate2 = false;

  @override
  void didChangeDependencies() {
    validateFullName();
    validatePhoneNumber();
    validateEmail();
    validatePassword();
    validatePassword2();
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
                    controller: _controllerFullName,
                    message: fullNameMessage,
                    validate: fullNameValidate,
                    label: 'Tên người dùng',
                    size: FTextFormFieldSize.size56,
                    value: fullName,
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                        userItem.fullName = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
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
                    controller: _controllerPhoneNumber,
                    message: phoneNumberMessage,
                    validate: phoneNumberValidate,
                    label: 'Số điện thoại',
                    size: FTextFormFieldSize.size56,
                    keyboardType: TextInputType.phone,
                    value: phoneNumber,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                        userItem.phoneNumber = value;
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
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: FTextFormField(
                    controller: _controllerPass2,
                    message: passwordMessage2,
                    validate: passwordValidate2,
                    label: 'Nhập lại mật khẩu',
                    size: FTextFormFieldSize.size56,
                    rightIcon: obscureText2
                        ? FFilledIcons.eye
                        : FFilledIcons.eye_invisible,
                    value: password2,
                    obscureText: obscureText2,
                    onRightIconPressed: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        password2 = value;
                        // userItem.password2 = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: FButton(
                    title: 'Đăng ký',
                    color: FColors.grey1,
                    backgroundColor: FColors.green6,
                    size: FButtonSize.size48,
                    block: true,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setLoginMessage();
                      validateFullName();
                      validatePhoneNumber();
                      validateEmail();
                      validatePassword();
                      validatePassword2();
                      setState(() {
                        isLoading = true;
                      });
                      if (fullNameValidate == false &&
                          phoneNumberValidate == false &&
                          emailValidate == false &&
                          passwordValidate == false &&
                          passwordValidate2 == false) {
                        try {
                          var data = await userDA.signIn(userItem);
                          if (data.message == 'success') {
                            Navigator.pop(context);
                            showFSnackBar(
                              context,
                              FSnackBar(
                                position: FlushbarPosition.TOP,
                                backgroundColor: FColors.green6,
                                borderRadius: 8.0,
                                icon: FIcon(
                                  icon: FOutlinedIcons.close_circle,
                                  size: 24,
                                  color: [FColors.grey1],
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                message: FText(
                                  "Tạo tài khoản thành công",
                                  color: FColors.grey1,
                                ),
                              ),
                            );
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
                                  "Tạo tài khoản không thành công, Tên đăng nhập đã tồn tại",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setLoginMessage() {
    if (fullName == '' || fullName == null) {
      setState(() {
        fullNameMessage = "Vui lòng nhập tên";
      });
    } else {
      setState(() {
        fullNameMessage = null;
      });
    }

    if (phoneNumber == '' || phoneNumber == null) {
      setState(() {
        phoneNumberMessage = "Vui lòng nhập số điện thoại";
      });
    } else {
      setState(() {
        phoneNumberMessage = null;
      });
    }

    if (email == '' || email == null) {
      setState(() {
        emailMessage = "Vui lòng nhập tài khoản";
      });
    } else if (!email.isEmail()) {
      setState(() {
        emailMessage = "Tên tài khoản không hợp lệ";
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
      passwordMessage = null;
    }

    if (password2 == '' || password2 == null) {
      setState(() {
        passwordMessage2 = "Vui lòng nhập mật khẩu";
      });
    } else if (password2 != password) {
      setState(() {
        passwordMessage2 = "Mật khẩu không trùng khớp";
      });
    } else {
      setState(() {
        passwordMessage2 = null;
      });
    }
  }

  void validateFullName() {
    if (fullNameMessage == '' || fullNameMessage == null) {
      setState(() {
        fullNameValidate = false;
      });
    } else {
      setState(() {
        fullNameValidate = true;
      });
    }
  }

  void validatePhoneNumber() {
    if (phoneNumberMessage == '' || phoneNumberMessage == null) {
      setState(() {
        phoneNumberValidate = false;
      });
    } else {
      setState(() {
        phoneNumberValidate = true;
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

  void validatePassword2() {
    if (passwordMessage2 == '' || passwordMessage2 == null) {
      setState(() {
        passwordValidate2 = false;
      });
    } else {
      setState(() {
        passwordValidate2 = true;
      });
    }
  }
}
