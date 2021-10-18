import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/DA/PresentDA.dart';

import '../../Students/StudentItem.dart';
import '../Choice.dart';
import '../PresentRequest.dart';
import '../PresentationItem.dart';
import '../Question.dart';

class ScanProvider extends ChangeNotifier {
  final PresentDA _presentDA = PresentDA();
  List<StudentItem> students;
  Question question;
  List<Choice> choices = <Choice>[];
  PresentationItem present;

  int i;

  Future<void> init(PresentationItem present, Question question,
      List<StudentItem> students) async {
    this.students = students;
    this.question = question;
    this.present = present;
    final presentCache = await _presentDA.getPresentFromCache(present.id);
    List<AnswerData> answers;

    if (presentCache != null && presentCache.answerData != null) {
      answers = presentCache.answerData
          .where((element) => element.itemId == question.id)
          .toList();
    }
    choices = question.choices;

    choices.forEach((element) {
      element.totalSelected = 0;
      // answers.where((e) => e.answer == int.parse(element.id)).length;
    });

    students.forEach((element) {
      final student = answers.firstWhere(
        (e) => e.studentId == element.id,
        orElse: () => null,
      );
      if (student != null) {
        element.answer = student.answer.toString();
      } else {
        element.answer = null;
      }
    });

    notifyListeners();
  }

  void setChoices(List<Choice> choices) {
    this.choices = choices;
    notifyListeners();
  }

  void resetAnswer() {
    choices.forEach((element) {
      element.totalSelected = 0;
    });
    students.forEach((element) {
      element.answer = null;
    });
    notifyListeners();
  }

  int totalTrue() =>
      students.where((e) => e.answer == question.dataResponse).length;

  int totalFalse() => students
      .where((e) =>
          e.answer != question.dataResponse &&
          !(e.answer == null || e.answer == ''))
      .length;

  int answered() => students.where((e) => e.answer != null).length;
}
