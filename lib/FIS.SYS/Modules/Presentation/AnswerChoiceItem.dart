class AnswerChoice {
  String s1;
  String s2;
  String s3;
  String s4;

  AnswerChoice({this.s1, this.s2, this.s3, this.s4});

  factory AnswerChoice.fromJson(Map<String, dynamic> json) => AnswerChoice(
        s1: json['1'],
        s2: json['2'],
        s3: json['3'],
        s4: json['4'],
      );
}
