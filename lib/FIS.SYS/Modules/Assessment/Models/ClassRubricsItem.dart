class ClassRubricsItem {
  int id;
  String rubricCode;
  String rubricName;

  ClassRubricsItem({this.id, this.rubricCode});

  ClassRubricsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rubricCode = json['code'];
    rubricName = json['name'];
  }
}
