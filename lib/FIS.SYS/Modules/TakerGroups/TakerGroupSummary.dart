import 'TakerClass.dart';

class TakerGroupSummary {
  String companyCode;
  int testTakerClassId;
  int testTakerGroupId;
  int testTakerStatusTotal;
  int testTakerStatusTodo;
  int testTakerStatusDoing;
  int testTakerStatusDone;
  int testFormCount;
  String testTakerMarkAvgDone;
  String testTakerMarkStdDev;
  List<Map<int, int>> testTakerMarkHistogram;
  List<TakerClass> takerClasses;
  List<TakerClass> testTakerGroupData;
  List<TakerClass> fromDatas;
  TakerGroupSummary(
      {this.companyCode,
      this.testTakerClassId,
      this.testTakerGroupId,
      this.testTakerStatusDoing,
      this.testTakerStatusDone,
      this.testTakerStatusTodo,
      this.testTakerStatusTotal,
      this.testFormCount,
      this.testTakerMarkAvgDone,
      this.testTakerMarkStdDev,
      this.testTakerMarkHistogram,
      this.takerClasses,
      this.testTakerGroupData});
  factory TakerGroupSummary.fromJson(Map<String, dynamic> json) {
    final user = TakerGroupSummary(
      companyCode: json['company_code'],
      testTakerClassId: (json['test_taker_class_id'] as num)?.toInt(),
      testTakerGroupId: json['test_taker_group_id'] != null
          ? int.parse(json['test_taker_group_id'].toString())
          : null,
      testTakerStatusTotal: (json['test_taker_status_total'] as num)?.toInt(),
      testTakerStatusDoing: (json['test_taker_status_doing'] as num)?.toInt(),
      testTakerStatusDone: (json['test_taker_status_done'] as num)?.toInt(),
      testTakerStatusTodo: (json['test_taker_status_todo'] as num)?.toInt(),
      testFormCount: (json['test_form_count'] as num)?.toInt(),
      testTakerMarkAvgDone: json['test_taker_mark_avg_done'],
      testTakerMarkStdDev: json['test_taker_mark_std_dev'],
    );
    final list = json['test_taker_class_data'] as List;
    final classData = json['test_taker_group_data'] as List;
    final fromData = json['test_form_data'] as List;
    var histogram = json['test_taker_mark_histogram'] as List;

    user.takerClasses =
        list != null ? list.map((c) => TakerClass.fromJson(c)).toList() : [];
    user.fromDatas = fromData != null
        ? fromData.map((c) => TakerClass.fromJson(c)).toList()
        : [];
    histogram ??= [];
    user.testTakerGroupData = classData != null
        ? classData.map((c) => TakerClass.fromJson(c)).toList()
        : [];

    user.testTakerMarkHistogram = <Map<int, int>>[];
    for (final item in histogram) {
      final tmp = item as Map;
      final key = tmp.keys.first;
      user.testTakerMarkHistogram.add({int.parse(key): item[key]});
    }
    //user.testTakerMarkHistogram = c;
    return user;
  }
}
