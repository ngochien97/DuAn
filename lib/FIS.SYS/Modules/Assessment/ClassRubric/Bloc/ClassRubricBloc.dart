import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/DA/ClassRubricDA.dart';

import 'ClassRubricEvent.dart';
import 'ClassRubricState.dart';

class ClassRubricBloc extends Bloc<ClassRubricEvent, ClassRubricState> {
  ClassRubricBloc() : super(LoadingState());
  int pageNumber = 1;
  final da = ClassRubricDA();
  @override
  Stream<ClassRubricState> mapEventToState(ClassRubricEvent event) async* {
    if (event is LoadFirstEvent) {
      yield LoadingState();
      final data = await da.getAssessmentMyClasses();
      if (data.code == 200) {
        yield SuccessState(data.classes);
      }
    }
    if (event is RefreshEvent) {
      final data = await da.getAssessmentMyClasses();
      if (data.code == 200) {
        yield SuccessState(data.classes);
      }
    }
    if (event is AppendRubricEvent) {
      final data = state.classes.firstWhere(
          (element) => element.id == event.classid,
          orElse: () => null);
      if (data != null) {
        yield SuccessState(state.classes,
            txtSearch: state.txtSearch ?? state.txtSearch,
            grades: state.grades ?? state.grades);
      }
    }
    if (event is RemoveRubricEvent) {
      final data = state.classes.firstWhere(
          (element) => element.id == event.classid,
          orElse: () => null);
      if (data != null) {
        data.classRubrics = data.classRubrics
            .where((element) => element.id != event.classRubricId)
            .toList();

        yield SuccessState(state.classes,
            txtSearch: state.txtSearch ?? state.txtSearch,
            grades: state.grades ?? state.grades);
      }
    }
    if (event is SearchEvent) {
      yield SuccessState(state.classes,
          txtSearch: event.txt ?? state.txtSearch,
          grades: event.grades ?? state.grades);
    }
  }
}
