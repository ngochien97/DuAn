import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isActive = false;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  void save(dynamic value) {
    setState(() {
      isActive = value;
    });
    if (isActive) {
      _storage.write(key: 'activeFlip', value: '1');
    } else {
      _storage.write(key: 'activeFlip', value: '0');
    }
  }

  Future<void> getFlip() async {
    final flip = await _storage.read(key: 'activeFlip');
    if (flip == '1') {
      setState(() {
        isActive = true;
      });
    } else {
      setState(() {
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    getFlip();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: FColors.grey2,
        appBar: FAppBar(
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            color: FColors.grey10,
            backgroundColor: FColors.transparent,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Cài đặt',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerActions: [
            Container(
              width: 48,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: FText(
                'Thiết lập chế độ camera tương thích, cho phép ứng dụng tối ưu camera của thiết bị.',
                color: FColors.grey7,
              ),
            ),
            FListTitle(
              round: false,
              title: FText(
                'Tối ưu hóa camera',
                style: FTextStyle.titleModules4,
              ),
              action: [
                FSwitch(
                  activeBackgroundColor: SkinColor.primary,
                  onChanged: save,
                  value: isActive,
                ),
              ],
            ),
          ],
        ),
      );
}
