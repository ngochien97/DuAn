import '../../Models/ClassRubricItem.dart';

abstract class RubricInClassState {
  ClassRubricItem classes;

  RubricInClassState({this.classes});
}

class SuccessState extends RubricInClassState {
  SuccessState(ClassRubricItem classes) : super(classes: classes);
}
