import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Tag.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';

class ClassRubricCard extends StatelessWidget {
  final ClassRubricItem classRubric;
  const ClassRubricCard(this.classRubric, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () {
              CoreRoutes.instance.navigateTo(RouteNames.LIST_RUBRIC_OF_CLASS,
                  arguments: classRubric);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FText(
                          '${classRubric.name}',
                          maxLines: 2,
                          style: FTextStyle.bodyText2,
                          overflow: TextOverflow.clip,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: FText(
                            '${classRubric.studentCount} học sinh',
                            style: FTextStyle.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  FTag(
                    title: '${classRubric.rubricCount} Rubric',
                    color: classRubric.rubricCount > 0
                        ? FColors.green6
                        : FColors.orange6,
                    backgroundColor: classRubric.rubricCount > 0
                        ? FColors.green1
                        : FColors.orange1,
                    leftIcon: classRubric.rubricCount > 0
                        ? FOutlinedIcons.check
                        : FOutlinedIcons.close,
                  )
                ],
              ),
            ),
          ),
        ),
        FDivider(),
      ],
    );
  }
}
