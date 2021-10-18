import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/ClassDetail.dart';
import '../../FIS.SYS/Modules/TakerGroups/TakerClass.dart';
import '../../FIS.SYS/Styles/Colors.dart';

class ClassDetailScreen extends StatefulWidget {
  final TakerClass item;
  const ClassDetailScreen({this.item});
  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  Widget build(BuildContext context) => FBottomSheet(
        header: FModal(
          title: FText('${widget.item.testTakerClassName}'),
        ),
        body: Expanded(
          child: Container(
              color: FColors.grey2,
              child: ClassDetailView(
                  widget.item.testTakerClassId,
                  widget.item.testTakerGroupId,
                  widget.item.testTakerClassName)),
        ),
      );
}
