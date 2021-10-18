class TestTaker {
  int id;
  String name;
  String studentNumber;
  String code;
  DateTime startedAt;
  DateTime submittedAt;
  int status;
  String companyCode;
  String className;
  String testFormGroupCode;
  String testFormCode;
  String score;
  String point;
  String totalPoint;
  int studentId;

  TestTaker(
      {this.className,
      this.code,
      this.companyCode,
      this.id,
      this.name,
      this.score,
      this.startedAt,
      this.studentNumber,
      this.submittedAt,
      this.status,
      this.testFormCode,
      this.testFormGroupCode,
      this.point,
      this.studentId,
      this.totalPoint});
  factory TestTaker.fromJson(Map<String, dynamic> json) {
    final data = TestTaker(
      id: json['id'],
      name: json['name'],
      studentNumber: json['student_number'],
      code: json['code'],
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at']),
      submittedAt: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at']),
      status: json['status'],
      companyCode: json['company_code'],
      className: json['class_name'],
      testFormGroupCode: json['test_form_group_code'],
      testFormCode: json['test_form_code'],
      score: json['score'],
      point: json['point'],
      totalPoint: json['total_point'],
      studentId: json['student_id'],
    );
    return data;
  }
}
