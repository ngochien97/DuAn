import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    String value;

    return Consumer<AuthProvider>(
      builder: (context, authprovider, child) => Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: FTextField(
          size: FTextFieldSize.size56,
          label: 'Số điện thoại',
          value: value,
          onChanged: (value) => authprovider.setDisplayUserData(
            User(
              id: authprovider.getUserData.id,
              fullName: authprovider.getUserData.fullName,
              email: authprovider.getUserData.email,
              phoneNumber: value,
              orgId: authprovider.getUserData.orgId,
              avatarBase64: authprovider.getUserData.avatarBase64,
            ),
          ),
        ),
      ),
    );
  }
}
