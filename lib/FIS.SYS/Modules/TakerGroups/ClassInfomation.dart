class ClassInfomation {
  int id;
  String name;
  String code;
  bool isActive = false;
  ClassInfomation({this.name, this.code, this.id});
  factory ClassInfomation.fromJson(Map<String, dynamic> json) =>
      ClassInfomation(id: json['id'], name: json['name'], code: json['code']);
}
