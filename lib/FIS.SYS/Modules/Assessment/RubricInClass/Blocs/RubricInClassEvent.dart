import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';

abstract class RubricInClassEvent {}

class LoadFirstEvent extends RubricInClassEvent {}

class AppendEvent extends RubricInClassEvent {
  ClassRubrics rubric;
  AppendEvent(this.rubric);
}

class RemoveEvent extends RubricInClassEvent {
  ClassRubrics rubric;
  RemoveEvent(this.rubric);
}

class SearchEvent extends RubricInClassEvent {
  String txt;
  List<String> grades;
  SearchEvent({this.txt, this.grades});
}
