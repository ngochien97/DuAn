import 'package:khao_thi_gv/FIS.SYS/Core/BaseResponse.dart';

class AnswerPresentation {
  int itemId;
  List<Answers> answers;

  AnswerPresentation({this.itemId, this.answers});

  AnswerPresentation.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = itemId;
    if (answers != null) {
      data['answers'] = answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int studentId;
  String answer;

  Answers({this.studentId, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['answer'] = answer;
    return data;
  }
}

class AnswerPresentationModel extends BaseResponse {
  List<AnswerPresentation> answers = [];
  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final jsonList = json['data']['items'];
      if (jsonList != null) {
        final list = jsonList as List;
        answers = list.map((c) => AnswerPresentation.fromJson(c)).toList();
      }
    }
  }
}
