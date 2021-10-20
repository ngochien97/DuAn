import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TextFormField.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  final String validateMessage;
  final Function onChangeName;

  const EditName({
    Key key,
    this.validateMessage,
    this.onChangeName,
  }) : super(key: key);

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  TextEditingController _nameController = new TextEditingController();
  bool validateEitName = false;

  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  void didUpdateWidget(EditName oldWidget) {
    if (widget.validateMessage != oldWidget.validateMessage) {
      setValidate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    String value =
        Provider.of<UserProvider>(context, listen: false).getUser.fullName;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: FTextFormField(
          controller: _nameController,
          autoFocus: true,
          size: FTextFormFieldSize.size56,
          message: widget.validateMessage,
          validate: validateEitName,
          label: 'Tên đầy đủ',
          value: value,
          onChanged: (value) {
            widget.onChangeName(value);
          }),
    );
  }

  void setValidate() {
    if (widget.validateMessage == null) {
      setState(() {
        validateEitName = false;
      });
    } else {
      setState(() {
        validateEitName = true;
      });
    }
  }
}
