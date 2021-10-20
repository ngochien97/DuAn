import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  UserItem userItem = new UserItem("daily.qc@gmail.com", "1234567", false);
  bool obscureText = true;
  bool isLoading = false;
  var focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: SingleChildScrollView(
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
                padding: EdgeInsets.only(top: 30),
                child: FTextField(
                  label: 'Tên Tài Khoản',
                  size: FTextFieldSize.size56,
                  value: userItem.email,
                  onChanged: (value) {
                    setState(() {
                      userItem.email = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: FTextField(
                  label: 'Mật khẩu',
                  size: FTextFieldSize.size56,
                  rightIcon: obscureText
                      ? FFilledIcons.eye
                      : FFilledIcons.eye_invisible,
                  value: userItem.password,
                  obscureText: obscureText,
                  onRightIconPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      userItem.password = value;
                    });
                  },
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: EdgeInsets.only(top: 21),
                    child: FButton(
                      title: 'Quên mật khẩu?',
                      color: FColors.green6,
                      onPressed: () {},
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
                  onPressed: () {
                    if (isLoading) {
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    UserDA.login(userItem, context);
                  },
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
