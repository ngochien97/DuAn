import '../../Models/GradesItem.dart';

abstract class GradesState {
  List<GradesItem> grades = [];
  GradesState({this.grades});
}

class LoadingState extends GradesState {}

class SuccessState extends GradesState {
  SuccessState(List<GradesItem> grades) : super(grades: grades);
}
