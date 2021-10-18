class ConfigAPI {
  // 'https://staging-mapi.xcbt.online/';

  static const String userInfo = 'api/Teacher/get_user_profile';
  static const String companyInfo = 'api/Teacher/get_user_company';
  static const String getStat = 'api/Teacher/get_test_taker_stats';

  static const String testTakerGroupActived =
      'api/Teacher/get_test_taker_group_actived';
  static const String testTakerGroupClosed =
      'api/Teacher/get_test_taker_group_closed';
  static const String testTakerGroupDeleted =
      'api/Teacher/get_test_taker_group_deleted';
  static const String takerGroupStart =
      'api/Teacher/control_test_taker_group_start';
  static const String takerGroupPause =
      'api/Teacher/control_test_taker_group_pause';
  static const String takerGroupLock =
      'api/Teacher/control_test_taker_group_lock';
  static const String takerGroupStop =
      'api/Teacher/control_test_taker_group_stop';
  static const String takerGroupDelete = 'api/Teacher/delete_test_taker_group';
  static const String takerGroupRestore =
      'api/Teacher/restore_test_taker_group';
  static const String takerGroupGetSumary =
      'api/Teacher/test_taker_group_get_sumary';
  static const String takerGroupGetTestTaker =
      'api/Teacher/test_taker_group_get_test_taker';
  static const String getTestTakerClassInfomation =
      'api/Teacher/get_test_taker_class_infomation';
  static const String classGetSumary =
      'api/Teacher/test_taker_group_get_class_sumary';
  static const String updateTestTakerGroup =
      'api/Teacher/update_test_taker_group';
  static const String getTestTakerResult =
      'api/Teacher/get_test_taker_result?id=';
  static const String getStudentInClass =
      'api/Presentation/get_list_student_for_class?class_id=';
  static const String getClassHasPresent = 'api/Presentation/get_list_class';
  static const String getPresentsByClass =
      'api/Presentation/get_list_presentation_for_class';
  static const String postAnswer =
      'api/Presentation/submit_result_for_presentation';
  static const String postStartPresentation =
      'api/Presentation/presentation_start';
  static const String getQuestionInPresentation =
      'api/Presentation/test_form_view_detail';
  static const String getHistoryPresentsByClass =
      'api/Presentation/get_list_history_presentation_for_class';
  static const String getAnswerForPresentation =
      'api/Presentation/get_list_history_presentation_details';
  static const String getSearch = 'api/Reports/ProgressReports/test_outline';
  static const String getTableStats =
      'api/Reports/ProgressReports/stats_test_blueprint';
  static const String getTableStudentReport =
      'api/Reports/ProgressReports/stats_summary';
  static const String statsTestBlueprint =
      'api/Reports/ProgressReports/stats_test_blueprint';
  static const String statsTestOutline =
      'api/Reports/ProgressReports/stats_test_outline';
  static const String assessmentMyClasses = 'api/Assessment/my-classes';
  static const String myGrades = 'api/Assessment/my-grades';
  static const String searchRubric = 'api/Assessment/search-rubric';
  static const String appendRubric = 'api/Assessment/append-rubric';
  static const String removeRubric = 'api/Assessment/remove-rubric';
}
