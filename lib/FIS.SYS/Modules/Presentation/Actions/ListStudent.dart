import 'package:flutter/material.dart';

import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../../Students/StudentItem.dart';

class ListStudentScreen extends StatefulWidget {
  final List<StudentItem> students;
  const ListStudentScreen(this.students);
  @override
  _ListStudentScreenState createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
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
              'Danh sách học sinh',
              style: FTextStyle.titleModules3,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 12.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.students.length,
            itemBuilder: (context, index) => FListTitle(
              dividerIndent: true,
              round: false,
              avatar: FBoundingBox(
                size: FBoxSize.size32x32,
                type: FBoundingBoxType.circle,
                child: FIcon(
                  icon: FFilledIcons.hat,
                  size: 20.0,
                  color: const <Color>[FColors.grey6, FColors.grey6],
                ),
              ),
              title: FText(widget.students[index].name),
            ),
          ),
        ),
      );
}
