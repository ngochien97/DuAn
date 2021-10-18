import 'package:flutter/material.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/User/Actions/SelectVersion.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/Colors.dart';
import '../../FIS.SYS/Styles/Icons.dart';

class VersionScreen extends StatefulWidget {
  final bool changeVer;
  const VersionScreen({this.changeVer});
  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: widget.changeVer == true
            ? FAppBar(
                headerLead: FIconButton(
                  icon: FOutlinedIcons.left,
                  backgroundColor: FColors.transparent,
                  color: FColors.grey9,
                  size: FIconButtonSize.size48,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                headerCenter: Container(
                  alignment: Alignment.center,
                  child: FText(
                    'Thay đổi phiên bản',
                    style: FTextStyle.titleModules3,
                  ),
                ),
                headerActions: [
                  Container(
                    width: 48,
                  )
                ],
              )
            : null,
        body: SelectVersion(changeVer: widget.changeVer),
      );
}
