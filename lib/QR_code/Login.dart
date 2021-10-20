import 'package:Framework/FIS.SYS/Components/Button.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/QR_code/Home.dart';
import 'package:Framework/QR_code/Information.dart';
import 'package:flutter/material.dart';

class LoginQR extends StatefulWidget {
  @override
  _LoginQRState createState() => _LoginQRState();
}

class _LoginQRState extends State<LoginQR> {
  bool _obsureText = true;
  bool isLoading = false;
  UserItem userItem = new UserItem(email: "", password: "", isRemember: false);

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

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: FColors.grey1,
        body: Container(
          height: size.height,
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: FColors.grey1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.1,
                        size.height * 0.1, size.width * 0.16, 48),
                    child: Image.asset('lib/QR_code/Assets/logo.png')),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FTextField(
                    controller: _controllerEmail,
                    value: email,
                    message: emailMessage,
                    validator: emailValidate,
                    size: FTextFieldSize.size56,
                    label: 'name@gmail.com',
                    onChanged: (value) {
                      setState(() {
                        email = value;
                        userItem.email = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: FTextField(
                    controller: _controllerPass,
                    message: passwordMessage,
                    validator: passwordValidate,
                    size: FTextFieldSize.size56,
                    label: 'Mật khẩu',
                    value: password,
                    rightIcon: _obsureText
                        ? FFilledIcons.eye_invisible
                        : FFilledIcons.eye,
                    obscureText: _obsureText,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                        userItem.password = value;
                      });
                    },
                    onRightIconPressed: () {
                      setState(() {
                        _obsureText = !_obsureText;
                      });
                    },
                  ),
                ),
                FButton(
                  size: FButtonSize.size48,
                  block: true,
                  backgroundColor: SkinColor.primary,
                  title: 'Đăng nhập',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    setLoginMessage();
                    validateEmail();
                    validatePassword();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Information()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
