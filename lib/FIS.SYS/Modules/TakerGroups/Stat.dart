class Stat {
  String date;
  int countTestTakerStarted;
  int countTestTaker;

  Stat({this.date, this.countTestTaker, this.countTestTakerStarted});

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
      date: json['date'],
      countTestTaker: json['count_test_taker'],
      countTestTakerStarted: json['count_test_taker_started']);

  Stat fromJson(Map<String, dynamic> json) => Stat.fromJson(json);
}
