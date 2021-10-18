import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/DA/GradeDA.dart';

import 'GradesEvent.dart';
import 'GradesState.dart';

class GradesBloc extends Bloc<GradesEvent, GradesState> {
  GradesBloc() : super(LoadingState());
  int pageNumber = 1;
  final da = GradeDA();
  @override
  Stream<GradesState> mapEventToState(GradesEvent event) async* {
    if (event is LoadGradeFirstEvent) {
      yield LoadingState();
      final data = await da.getMyGrades();
      if (data.code == 200) {
        yield SuccessState(data.grades);
      }
    }
  }
}
