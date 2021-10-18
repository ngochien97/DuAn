import 'package:get_it/get_it.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/MQTTClientWrapper.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';

import 'FIS.SYS/Core/snackbar_bloc/SnackBarBloc.dart';
import 'FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => SnackBarBloc());
  locator.registerLazySingleton(() => NotificationBloc());
  locator.registerLazySingleton(() => ClassRubricBloc());
  locator.registerLazySingleton(() => MQTTClientWrapper());
}
