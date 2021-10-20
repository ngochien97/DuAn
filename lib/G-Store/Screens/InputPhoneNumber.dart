import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_GStore/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

class InputPhoneNumber extends StatefulWidget {
  InputPhoneNumber({Key key}) : super(key: key);

  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  TextEditingController _controller = new TextEditingController();
  UserItem userItem = new UserItem(phoneNumber: "");
  String inputValue = "";
  List<String> locationCode = ['+84', '+12', '+24', '+68', '+04'];
  String location = '+84';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                FText("Nhập số điện thoại của bạn",
                    style: FTextStyle.titleModules1),
                FText(
                    "Chúng tôi sẽ gửi gửi cho bạn một tin nhắn với mã xác nhận đăng nhập."),
                FSpacer.space16px,
                Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: FColors.grey1,
                        border: Border.all(width: 0.3, color: FColors.grey6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        value: location,
                        items: locationCode
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            location = newValue;
                          });
                        },
                        underline: Container(),
                      ),
                    ),
                    FSpacer.hozirontalSpace8px,
                    Expanded(
                      child: FTextFormField(
                          // controller: _controller,
                          // size: FTextFormFieldSize.size56,
                          // label: 'Số điện thoại',
                          // keyboardType: TextInputType.phone,
                          // value: inputValue,
                          // onChanged: (value) {
                          //   setState(() {
                          //     inputValue = value;
                          //     // userItem.phoneNumber = value;
                          //   });
                          // },
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
                      Navigator.pushNamed(context, 'input_otp');
                    },
                  ),
                ),
                FSpacer.space16px,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
