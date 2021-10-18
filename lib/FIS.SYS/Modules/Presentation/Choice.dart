class Choice {
  String id;
  String choiceName;
  int totalSelected;
  Choice({this.id, this.choiceName, this.totalSelected});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['choiceName'] = choiceName;
    data['totalSelected'] = totalSelected;
    return data;
  }
}
