import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserDA.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  final String oldPasswordMessage;
  final String newPasswordMessage1;
  final String newPasswordMessage2;

  final Function onChangeOldPassword;
  final Function onChangeNewPassword1;
  final Function onChangeNewPassword2;

  ChangePassword({
    this.oldPasswordMessage,
    this.newPasswordMessage1,
    this.newPasswordMessage2,
    this.onChangeOldPassword,
    this.onChangeNewPassword1,
    this.onChangeNewPassword2,
  });

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Initially password is obscure
  var _oldPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _newPasswordController2 = TextEditingController();

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  UserDA userDA = UserDA();

  String oldPassword = '';
  String newPassword1 = '';
  String newPassword2 = '';

  bool oldPasswordValidate = true;
  bool newPasswordValidate1 = true;
  bool newPasswordValidate2 = true;

  @override
  void didUpdateWidget(ChangePassword oldWidget) {
    if (widget.oldPasswordMessage != oldWidget.oldPasswordMessage) {
      validateOldPassword();
    }
    if (widget.newPasswordMessage1 != oldWidget.newPasswordMessage1) {
      validateNewPassword1();
    }
    if (widget.newPasswordMessage2 != oldWidget.newPasswordMessage2) {
      validateNewPassword2();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    validateOldPassword();
    validateNewPassword1();
    validateNewPassword2();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserItem newUser = Provider.of<UserProvider>(context).getNewUser;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        children: [
          FTextFormField(
            controller: _oldPasswordController,
            size: FTextFormFieldSize.size56,
            obscureText: _obscureText,
            autoFocus: true,
            rightIcon:
                _obscureText ? FFilledIcons.eye : FFilledIcons.eye_invisible,
            onRightIconPressed: _toggle,
            message: widget.oldPasswordMessage,
            validate: oldPasswordValidate,
            label: 'Mật khẩu cũ',
            value: oldPassword,
            onChanged: (value) {
              widget.onChangeOldPassword(value);
              newUser.password = value;
            },
          ),
          FSpacer.space24px,
          FTextFormField(
            controller: _newPasswordController,
            size: FTextFormFieldSize.size56,
            obscureText: _obscureText1,
            rightIcon:
                _obscureText1 ? FFilledIcons.eye : FFilledIcons.eye_invisible,
            onRightIconPressed: _toggle1,
            message: widget.newPasswordMessage1,
            validate: newPasswordValidate1,
            label: 'Mật khẩu mới',
            value: newPassword1,
            onChanged: (value) {
              widget.onChangeNewPassword1(value);
              newUser.newPassword = value;
            },
          ),
          FSpacer.space24px,
          FTextFormField(
            controller: _newPasswordController2,
            size: FTextFormFieldSize.size56,
            obscureText: _obscureText2,
            rightIcon:
                _obscureText2 ? FFilledIcons.eye : FFilledIcons.eye_invisible,
            onRightIconPressed: _toggle2,
            message: widget.newPasswordMessage2,
            validate: newPasswordValidate2,
            label: 'Nhập lại mật khẩu',
            value: newPassword2,
            onChanged: (value) {
              widget.onChangeNewPassword2(value);
              newUser.newPassword2 = value;
            },
          ),
        ],
      ),
    );
  }

  void validateOldPassword() {
    if (widget.oldPasswordMessage != null) {
      setState(() {
        oldPasswordValidate = true;
      });
    } else {
      setState(() {
        oldPasswordValidate = false;
      });
    }
  }

  void validateNewPassword1() {
    if (widget.newPasswordMessage1 != null) {
      setState(() {
        newPasswordValidate1 = true;
      });
    } else {
      setState(() {
        newPasswordValidate1 = false;
      });
    }
  }

  void validateNewPassword2() {
    if (widget.newPasswordMessage2 != null) {
      setState(() {
        newPasswordValidate2 = true;
      });
    } else {
      setState(() {
        newPasswordValidate2 = false;
      });
    }
  }
}
