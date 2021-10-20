import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              alignment: Alignment.centerRight,
              child: FButton(
                title: "Bỏ qua",
                color: FColors.blue6,
                backgroundColor: FColors.transparent,
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.145,
              ),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.45,
                child: SvgPicture.asset(
                  'lib/G-Store/Assets/Logo.svg',
                ),
              ),
            ),
            FSpacer.space16px,
            FText("G-Store", style: FTextStyle.largeTitle1),
            FText("Tech company"),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.145,
              ),
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Container(
                    child: FButton(
                      leftIcon: FFilledIcons.logo_facebok_circle,
                      title: "Đăng nhập bằng Facebook",
                      block: true,
                      size: FButtonSize.size48,
                      onPressed: () {},
                    ),
                  ),
                  FSpacer.space16px,
                  Container(
                    child: FButton(
                      leftIcon: FFilledIcons.phone,
                      backgroundColor: SkinColor.primary,
                      title: "Đăng nhập bằng Số điện thoại",
                      block: true,
                      size: FButtonSize.size48,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "input_phone_number_screen");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            FText('Bạn chưa có tài khoản?'),
            FButton(
              title: "Đăng ký",
              color: FColors.blue6,
              backgroundColor: FColors.transparent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
