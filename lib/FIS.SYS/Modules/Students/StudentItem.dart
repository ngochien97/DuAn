import 'package:hive/hive.dart';
part 'StudentItem.g.dart';

@HiveType(typeId: 0)
class StudentItem {
  @HiveField(0)
  int id;
  @HiveField(1)
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
  String testTime;
  @HiveField(2)
  int cardNumber;
  String answer;
  int totalItem;
  int correctAnswerCount;

  StudentItem(
      {this.className,
      this.code,
      this.companyCode,
      this.id,
      this.name,
      this.score,
      this.point,
      this.totalPoint,
      this.startedAt,
      this.studentNumber,
      this.submittedAt,
      this.status,
      this.testFormCode,
      this.testFormGroupCode,
      this.testTime,
      this.cardNumber,
      this.totalItem,
      this.correctAnswerCount});
  factory StudentItem.fromJson(Map<String, dynamic> json) {
    final data = StudentItem(
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
      cardNumber: json['card_number'],
      score: json['score'] == null
          ? ''
          : json['score'].contains('.')
              ? '${json["score"]}0000'
              : '${json["score"]}.0000',
      point: json['point'],
      totalPoint: json['total_point'],
      totalItem: json['total_items'],
      correctAnswerCount: json['correct_answer_count'],
    );
    return data;
  }

  String get lastName {
    if (name == null) {
      return '';
    }
    final arrays = name.split(' ');
    return arrays[arrays.length - 1];
  }
}
