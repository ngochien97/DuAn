class TakerClass {
  String companyCode;
  int testTakerClassId;
  String testTakerClassName;
  int testTakerGroupId;
  int testTakerStatusTotal;
  int testTakerStatusTodo;
  int testTakerStatusDoing;
  int testTakerStatusDone;
  String testFormCode;
  int testTakerQuestionTotal;
  double testTakerMarkAvg;
  double testTakerMarkDeviation;
  double testTakerMarkMin;
  double testTakerMarkMax;
  double testTakerQuestionCorrectAvg;
  TakerClass(
      {this.companyCode,
      this.testTakerClassId,
      this.testTakerGroupId,
      this.testTakerStatusDoing,
      this.testTakerStatusDone,
      this.testTakerStatusTodo,
      this.testTakerStatusTotal,
      this.testFormCode,
      this.testTakerMarkAvg,
      this.testTakerMarkDeviation,
      this.testTakerQuestionTotal,
      this.testTakerMarkMax,
      this.testTakerMarkMin,
      this.testTakerQuestionCorrectAvg});
  factory TakerClass.fromJson(Map<String, dynamic> json) {
    final user = TakerClass(
        companyCode: json['company_code'],
        testTakerClassId: (json['test_taker_class_id'] as num)?.toInt(),
        testTakerGroupId: (json['test_taker_group_id'] as num)?.toInt(),
        testTakerStatusTotal: (json['test_taker_status_total'] as num)?.toInt(),
        testTakerStatusDoing: (json['test_taker_status_doing'] as num)?.toInt(),
        testTakerStatusDone: (json['test_taker_status_done'] as num)?.toInt(),
        testTakerStatusTodo: (json['test_taker_status_todo'] as num)?.toInt(),
        testTakerMarkAvg: (json['test_taker_mark_avg'] as num)?.toDouble(),
        testTakerMarkMax: (json['test_taker_mark_max'] as num)?.toDouble(),
        testTakerMarkMin: (json['test_taker_mark_min'] as num)?.toDouble(),
        testTakerQuestionCorrectAvg:
            (json['test_taker_question_correct_avg'] as num)?.toDouble(),
        testTakerMarkDeviation:
            (json['test_taker_mark_deviation'] as num)?.toDouble(),
        testFormCode: json['test_form_code'],
        testTakerQuestionTotal:
            (json['test_taker_question_total'] as num)?.toInt());
    return user;
  }
}
