class TestFormItem {
  int id;
  int testFormGroupId;
  String code;
  String companyCode;
  DateTime createdTime;
  int itemCount;
  String name;
  int presentation;
  int status;
  String testBluePrintData;
  int timeLimit;
  DateTime updatedTime;

  TestFormItem({
    this.id,
    this.testFormGroupId,
    this.code,
    this.companyCode,
    this.createdTime,
    this.itemCount,
    this.name,
    this.presentation,
    this.status,
    this.testBluePrintData,
    this.timeLimit,
    this.updatedTime,
  });

  factory TestFormItem.fromJson(Map<String, dynamic> json) => TestFormItem(
      id: json['id'],
      testFormGroupId: json['test_form_group_id'],
      code: json['code'],
      companyCode: json['company_code'],
      createdTime: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at']),
      itemCount: json['item_count'],
      name: json['name'],
      presentation: json['presentation'],
      status: json['status'],
      testBluePrintData: json['test_blueprints_data'],
      timeLimit: json['time_limit'],
      updatedTime: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']));
}
