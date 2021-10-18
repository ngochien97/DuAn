import 'package:flutter/material.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/Presentation/Actions/ListHistory.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';

class HistoryScreen extends StatefulWidget {
  final int classId;
  HistoryScreen(this.classId);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: FColors.grey2,
        appBar: FAppBar(
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
              'Lịch sử',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerActions: [
            Container(
              width: 48,
            )
          ],
        ),
        body: ListHistory(widget.classId),
      );
}
