import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumber extends StatefulWidget {
  final String validateMessage;
  final Function onChangePhoneNumber;

  PhoneNumber({
    Key key,
    this.validateMessage,
    this.onChangePhoneNumber,
  }) : super(key: key);
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  var _phoneNumController = new TextEditingController();
  bool validatePhoneNumber = false;

  @override
  void didUpdateWidget(PhoneNumber oldWidget) {
    if (widget.validateMessage != oldWidget.validateMessage) {
      setValidate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    String value =
        Provider.of<UserProvider>(context, listen: false).getUser.phoneNumber;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: FTextFormField(
          controller: _phoneNumController,
          size: FTextFormFieldSize.size56,
          autoFocus: true,
          message: widget.validateMessage,
          validate: validatePhoneNumber,
          label: 'Số điện thoại',
          keyboardType: TextInputType.phone,
          value: value,
          onChanged: (value) {
            widget.onChangePhoneNumber(value);
          }),
    );
  }

  void setValidate() {
    if (widget.validateMessage == null) {
      setState(() {
        validatePhoneNumber = false;
      });
    } else {
      setState(() {
        validatePhoneNumber = true;
      });
    }
  }
}
