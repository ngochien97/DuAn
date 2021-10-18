import 'dart:convert';

import 'AnswerChoiceItem.dart';

class StudentAnswerItem {
  int id;
  int parentId;
  String answer;
  String body;
  AnswerChoice choices;
  String response;
  bool statusAnswer;
  String markRubric;
  int isParent;
  int index;
  int parentIndex;
  int type;
  List<StudentAnswerItem> children = [];

  StudentAnswerItem(
      {this.id,
      this.parentId,
      this.answer,
      this.choices,
      this.body,
      this.response,
      this.markRubric,
      this.statusAnswer,
      this.index,
      this.type,
      this.isParent});

  factory StudentAnswerItem.fromJson(Map<String, dynamic> json) {
    final data = StudentAnswerItem(
      id: json['id'],
      parentId: json['parent_id'],
      answer: json['answer'],
      body: json['data_body_html'],
      choices: json['data_choices_html'] != null
          ? AnswerChoice.fromJson(jsonDecode(json['data_choices_html']))
          : null,
      response: json['response'],
      markRubric: json['mark_rubric'],
      statusAnswer: json['status_answer'],
      type: json['type'],
      isParent: json['is_parent'],
    );
    return data;
  }
}
