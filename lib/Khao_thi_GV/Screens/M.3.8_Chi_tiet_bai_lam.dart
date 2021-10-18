import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_event.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/Students/StudentAnswerItem.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';

class TestDetail extends StatefulWidget {
  final List<StudentAnswerItem> studentAnswers;
  final List<StudentAnswerItem> listAnswersChildren;
  final ScrollController scrollController;

  final StudentDetailScrollParentBloc blocScrollParent;
  const TestDetail(this.studentAnswers, this.listAnswersChildren,
      this.scrollController, this.blocScrollParent);
  @override
  _TestDetailState createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  @override
  void initState() {
    super.initState();
  }

  Widget question({String answer, String rightAnswer, String index}) {
    Color color;
    Color borderColor;
    if (answer == null || answer == '') {
      color = FColors.grey7;
      borderColor = FColors.grey4;
    } else if (answer == rightAnswer) {
      color = FColors.green6;
      borderColor = FColors.green6;
    } else if (answer != '' && answer != null && answer != rightAnswer) {
      color = FColors.red6;
      borderColor = FColors.red6;
    }

    return FBoundingBox(
      backgroundColor: FColors.transparent,
      size: FBoxSize.size32x32,
      type: FBoundingBoxType.circle,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FText(
          index,
          textAlign: TextAlign.center,
          style: FTextStyle.titleModules6,
          color: color,
        ),
      ),
    );
  }

  List<Widget> buildRow() {
    final lst = <Widget>[];
    for (var i = 0; i < widget.studentAnswers.length; i++) {
      final parent = widget.studentAnswers[i];

      if (parent.isParent != 1) {
        lst.add(GestureDetector(
          onTap: () {
            Navigator.pop(context);
            widget.blocScrollParent.add(ScrollChangeEvent(i, 0));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: question(
              answer: parent.answer,
              index: '${parent.index}',
              rightAnswer: parent.response,
            ),
          ),
        ));
      } else {
        for (var j = 0; j < parent.children.length; j++) {
          final child = parent.children[j];
          lst.add(GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.blocScrollParent.add(ScrollChangeEvent(i, 0));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: question(
                answer: child.answer,
                index: '${child.index}',
                rightAnswer: child.response,
              ),
            ),
          ));
        }
      }
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: FBottomSheet(
        header: FModal(
          title: FText(
            'Chi tiết bài làm',
            style: FTextStyle.titleModules3,
          ),
        ),
        body: Expanded(
          child: Container(
            color: FColors.grey1,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: [...buildRow()],
            ),
          ),
        ),
      ),
    );
  }
}
