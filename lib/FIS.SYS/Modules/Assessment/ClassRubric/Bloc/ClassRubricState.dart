import '../../../../../F.Utils/Convert.dart';
import '../../Models/ClassRubricItem.dart';

abstract class ClassRubricState {
  List<ClassRubricItem> classes = [];
  String txtSearch = '';
  List<String> grades = [];
  List<ClassRubricItem> get classShow {
    final txt = (txtSearch ?? '').newUnicodeToAscii().toLowerCase();
    final lst = classes
        .where((element) =>
            _check(element.tags) &&
            element.name.newUnicodeToAscii().toLowerCase().contains(txt))
        .toList();
    return lst;
  }

  bool _check(String txt) {
    if (grades == null || grades.isEmpty) {
      return true;
    }
    for (final b in grades) {
      if (txt.contains(b)) {
        return true;
      }
    }

    return false;
  }

  ClassRubricState({this.classes, this.txtSearch, this.grades});
}

class LoadingState extends ClassRubricState {}

class SuccessState extends ClassRubricState {
  SuccessState(List<ClassRubricItem> classes,
      {String txtSearch, List<String> grades})
      : super(classes: classes, txtSearch: txtSearch, grades: grades);
}
