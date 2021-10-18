class StudentReportItem {
  StudentReportItem({
    this.pageSize,
    this.totalCount,
    this.studentReport,
    this.studentInfo,
  });

  int pageSize;
  int totalCount;
  List<StudentReport> studentReport;
  StudentInfo studentInfo;

  factory StudentReportItem.fromJson(Map<String, dynamic> json) =>
      StudentReportItem(
        pageSize: json['page_size'],
        totalCount: json['total_count'],
        studentReport: List<StudentReport>.from(
            json['student_report'].map((x) => StudentReport.fromJson(x))),
        studentInfo: StudentInfo.fromJson(json['student_info']),
      );

  Map<String, dynamic> toJson() => {
        'page_size': pageSize,
        'total_count': totalCount,
        'student_report':
            List<dynamic>.from(studentReport.map((x) => x.toJson())),
        'student_info': studentInfo.toJson(),
      };
}

class StudentInfo {
  StudentInfo({
    this.name,
    this.classId,
  });

  String name;
  int classId;

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
        name: json['name'],
        classId: json['class_id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'class_id': classId,
      };
}

class StudentReport {
  StudentReport({
    this.presentation,
    this.testTakerGroupId,
    this.testTakerGroupName,
    this.testFormId,
    this.testFormName,
    this.status,
    this.score,
    this.correctAnswerCount,
    this.totalItems,
    this.startedAt,
    this.submittedAt,
    this.id,
    this.testTakerMarkAvgDone,
  });

  bool presentation;
  int testTakerGroupId;
  String testTakerGroupName;
  int testFormId;
  String testFormName;
  int status;
  String score;
  int correctAnswerCount;
  int totalItems;
  DateTime startedAt;
  DateTime submittedAt;
  int id;
  String testTakerMarkAvgDone;

  factory StudentReport.fromJson(Map<String, dynamic> json) => StudentReport(
        presentation: json['presentation'],
        testTakerGroupId: json['test_taker_group_id'],
        testTakerGroupName: json['test_taker_group_name'],
        testFormId: json['test_form_id'],
        testFormName: json['test_form_name'],
        status: json['status'],
        score: json['score'],
        correctAnswerCount: json['correct_answer_count'],
        totalItems: json['total_items'],
        startedAt: DateTime.parse(json['started_at']),
        submittedAt: DateTime.parse(json['submitted_at']),
        id: json['id'],
        testTakerMarkAvgDone: json['test_taker_mark_avg_done'] == null
            ? null
            : json['test_taker_mark_avg_done'],
      );

  Map<String, dynamic> toJson() => {
        'presentation': presentation,
        'test_taker_group_id': testTakerGroupId,
        'test_taker_group_name': testTakerGroupName,
        'test_form_id': testFormId,
        'test_form_name': testFormName,
        'status': status,
        'score': score,
        'correct_answer_count': correctAnswerCount,
        'total_items': totalItems,
        'started_at': startedAt.toIso8601String(),
        'submitted_at': submittedAt.toIso8601String(),
        'id': id,
        'test_taker_mark_avg_done':
            testTakerMarkAvgDone == null ? null : testTakerMarkAvgDone,
      };
}
