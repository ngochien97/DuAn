import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricsItem.dart';

abstract class ClassRubricEvent {}

class LoadFirstEvent extends ClassRubricEvent {}

class RefreshEvent extends ClassRubricEvent {}

class AppendRubricEvent extends ClassRubricEvent {
  ClassRubricsItem rubric;
  int classid;
  AppendRubricEvent(this.rubric, this.classid);
}

class RemoveRubricEvent extends ClassRubricEvent {
  int classRubricId;
  int classid;
  RemoveRubricEvent(this.classid, this.classRubricId);
}

class SearchEvent extends ClassRubricEvent {
  String txt;
  List<String> grades;
  SearchEvent({this.txt, this.grades});
}
