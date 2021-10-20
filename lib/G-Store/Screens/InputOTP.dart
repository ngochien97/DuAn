import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

class InputOTP extends StatefulWidget {
  InputOTP({Key key}) : super(key: key);

  @override
  _InputOTPState createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP> {
  String value1 = '';
  String value2 = '';
  String value3 = '';
  String value4 = '';

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height - 24,
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    alignment: Alignment.centerLeft,
                    child: FIconButton(
                      icon: FOutlinedIcons.left,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: FColors.grey10,
                      backgroundColor: FColors.grey6.withOpacity(0.1),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  FSpacer.space16px,
                  FText("Nhập mã xác nhận", style: FTextStyle.titleModules1),
                  FText("Bạn không nhận được mã xác nhận đăng nhập?"),
                  GestureDetector(
                    child: FText(
                      " Gửi mã xác nhận mới.",
                      color: SkinColor.primary,
                    ),
                    onTap: () {},
                  ),
                  FSpacer.space16px,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 56,
                        child: FTextFormField(
                          focusNode: focus1,
                          textAlign: TextAlign.center,
                          controller: _controller1,
                          size: FTextFormFieldSize.size56,
                          keyboardType: TextInputType.phone,
                          value: value1,
                          maxLength: 1,
                          label: '',
                          onChanged: (value) {
                            setState(() {
                              value1 = value;
                            });
                            if (value1.length == 1) {
                              FocusScope.of(context).requestFocus(focus2);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 56,
                        child: FTextFormField(
                          focusNode: focus2,
                          textAlign: TextAlign.center,
                          controller: _controller2,
                          size: FTextFormFieldSize.size56,
                          keyboardType: TextInputType.phone,
                          value: value2,
                          maxLength: 1,
                          label: '',
                          onChanged: (value) {
                            setState(() {
                              value2 = value;
                            });
                            if (value2.length == 1) {
                              FocusScope.of(context).requestFocus(focus3);
                            } else {
                              FocusScope.of(context).requestFocus(focus1);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 56,
                        child: FTextFormField(
                          focusNode: focus3,
                          textAlign: TextAlign.center,
                          controller: _controller3,
                          size: FTextFormFieldSize.size56,
                          keyboardType: TextInputType.phone,
                          value: value3,
                          maxLength: 1,
                          label: '',
                          onChanged: (value) {
                            setState(() {
                              value3 = value;
                            });
                            if (value3.length == 1) {
                              FocusScope.of(context).requestFocus(focus4);
                            } else {
                              FocusScope.of(context).requestFocus(focus2);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 56,
                        child: FTextFormField(
                          focusNode: focus4,
                          textAlign: TextAlign.center,
                          controller: _controller4,
                          size: FTextFormFieldSize.size56,
                          keyboardType: TextInputType.phone,
                          value: value4,
                          maxLength: 1,
                          label: '',
                          onChanged: (value) {
                            setState(() {
                              value4 = value;
                            });
                            if (value4.length == 0) {
                              FocusScope.of(context).requestFocus(focus3);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  FSpacer.space24px,
                  Expanded(child: Container()),
                  Container(
                    child: FButton(
                      backgroundColor: SkinColor.primary,
                      title: "Tiếp tục",
                      block: true,
                      size: FButtonSize.size48,
                      onPressed: () {
                        Navigator.pushNamed(context, 'profile_screen');
                      },
                    ),
                  ),
                  FSpacer.space16px,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
