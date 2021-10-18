import 'dart:convert';

import '../../Core/BaseResponse.dart';

import 'Choice.dart';

class Question {
  int id;
  String dataBodyHtml;
  List<Choice> choices = <Choice>[];
  String dataResponse;

  Question({this.id, this.dataBodyHtml, this.choices, this.dataResponse});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['item_id'];
    dataBodyHtml = json['data_body_html'];
    final strdata = json['data_choices_html'] as String;
    // strdata = strdata.replaceAll("\\", "\\\\");
    final dataChoices = jsonDecode(strdata) as Map;

    if (dataChoices != null) {
      dataChoices.forEach((key, value) {
        choices.add(Choice(id: key, choiceName: value, totalSelected: 0));
      });
    }

    dataResponse = (json['data_response'] as String)?.replaceAll('\"', '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = id;
    data['data_body_html'] = dataBodyHtml;
    data['data_response'] = dataResponse;
    final str = [];
    choices.forEach((element) {
      str.add('"${element.id}":"${element.choiceName}"');
    });
    final temp = "{${str.join(",")}}";

    data['data_choices_html'] = temp;
    return data;
  }
}

class QuestionModel extends BaseResponse {
  List<Question> items;

  @override
  void fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (code == 200) {
      final list = json['data']['testFormItems'] as List;
      items = list.map((c) => Question.fromJson(c)).toList();
    }
  }
}
