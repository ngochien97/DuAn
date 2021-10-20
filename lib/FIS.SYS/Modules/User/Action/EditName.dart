import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  @override
  Widget build(BuildContext context) {
    String value;
    return Consumer<AuthProvider>(
      builder: (context, authprovider, child) => Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: FTextField(
          size: FTextFieldSize.size56,
          label: 'Tên đầy đủ',
          value: value,
          onChanged: (value) => authprovider.setDisplayUserData(
            User(
              id: authprovider.getUserData.id,
              fullName: value,
              email: authprovider.getUserData.email,
              phoneNumber: authprovider.getUserData.phoneNumber,
              orgId: authprovider.getUserData.orgId,
              avatarBase64: authprovider.getUserData.avatarBase64,
            ),
          ),
        ),
      ),
    );
  }
}
