import 'package:flutter/cupertino.dart';

import '../../../Components/ComponentsBase.dart';
import '../../../Styles/Colors.dart';
import '../../Students/StudentItem.dart';

class ListStudentAnswer extends StatelessWidget {
  final List<StudentItem> students;
  final String dataResponse;
  const ListStudentAnswer(this.students, this.dataResponse);

  @override
  Widget build(BuildContext context) => Container(
        child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Column(
                children: [
                  FListTitle(
                    avatar: FBoundingBox(
                      size: FBoxSize.size8x8,
                      backgroundColor: student.answer == null
                          ? FColors.grey6
                          : student.answer == dataResponse
                              ? FColors.green6
                              : FColors.red6,
                      type: FBoundingBoxType.circle,
                      child: Container(),
                    ),
                    title: FText(
                      "${student.name} ${student.answer ?? ""}",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  FDivider()
                ],
              );
            }),
      );
}
