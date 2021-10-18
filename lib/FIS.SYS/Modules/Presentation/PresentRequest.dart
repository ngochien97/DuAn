class PresentRequest {
  int id;
  List<AnswerData> answerData = <AnswerData>[];

  PresentRequest({this.id, this.answerData});

  PresentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['answer_data'] != null) {
      answerData = <AnswerData>[];
      json['answer_data'].forEach((v) {
        answerData.add(AnswerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (answerData != null) {
      data['answer_data'] = answerData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerData {
  int studentId;
  int itemId;
  int answer;

  AnswerData({this.studentId, this.itemId, this.answer});

  AnswerData.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    itemId = json['item_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['item_id'] = itemId;
    data['answer'] = answer;
    return data;
  }
}
