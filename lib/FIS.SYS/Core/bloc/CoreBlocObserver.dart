import 'package:bloc/bloc.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';

// We can extend `BlocObserver` and override `onTransition` and `onError`
// in order to handle transitions and errors from all Blocs.
class CoreBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    Utils.console(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    Utils.console(error);
    super.onError(cubit, error, stackTrace);
  }
}
