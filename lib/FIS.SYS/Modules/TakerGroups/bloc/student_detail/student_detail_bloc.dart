import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_event.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_state.dart';

class StudentDetailBloc extends Bloc<StudentDetailEvent, StudentDetailState> {
  StudentDetailBloc(StudentDetailState initialState) : super(initialState);

  @override
  Stream<StudentDetailState> mapEventToState(StudentDetailEvent event) async* {
    if (event is ScrollChangeEvent) {
      yield ScrollState(event.index, event.tabIndex);
    }
    if (event is ParentScrollChangeEvent) {
      yield ScrollParentState(event.index, event.tabIndex);
    }
  }
}

class StudentDetailScrollParentBloc extends StudentDetailBloc {
  StudentDetailScrollParentBloc(StudentDetailState initialState)
      : super(initialState);
}
