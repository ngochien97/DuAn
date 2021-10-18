import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/DA/ClassRubricDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';

import 'RubricInClassEvent.dart';
import 'RubricInClassState.dart';

class RubricInClassBloc extends Bloc<RubricInClassEvent, RubricInClassState> {
  ClassRubricItem classes;
  RubricInClassBloc(this.classes) : super(SuccessState(classes));
  int pageNumber = 1;
  final da = ClassRubricDA();
  @override
  Stream<RubricInClassState> mapEventToState(RubricInClassEvent event) async* {
    if (event is AppendEvent) {
      final classRubric = state.classes;
      classRubric.classRubrics.add(event.rubric);
      yield SuccessState(classRubric);
    }
    if (event is RemoveEvent) {
      final classRubric = state.classes;
      classRubric.classRubrics.remove(event.rubric);
      yield SuccessState(classRubric);
    }
  }
}
