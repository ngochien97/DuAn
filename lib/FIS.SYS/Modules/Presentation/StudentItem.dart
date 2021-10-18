class StudentItem2 {
  int id;
  String name;
  int cardNumber;
  String answer;

  StudentItem2({this.id, this.name, this.cardNumber, this.answer});

  StudentItem2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cardNumber = json['card_number'];
  }
}
