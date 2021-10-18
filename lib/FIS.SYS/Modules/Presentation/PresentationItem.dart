import 'Question.dart';

class PresentationItem {
  int id;
  String name;
  String code;
  List<Question> items;
  int totalItems;
  int status;
  int testFormId;
  String updatedAt;
  int currentItemIndex;
  bool isSaving = false;
  List<int> questionScanedIds = [];
  int testTakerGroupId;
  String get statusName {
    switch (status) {
      case 1:
        return 'Mới khởi tạo';
      case 2:
        return 'Đang trình chiếu';
      case 3:
        return 'Kết thúc';
      default:
        return '';
    }
  }

  PresentationItem(
      {this.id, this.name, this.code, this.items, this.currentItemIndex});

  PresentationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
    testFormId = json['test_form_id'];
    final lst = json['items'] as List;
    totalItems = json['item_count'];
    updatedAt = json['updated_at'];
    testTakerGroupId = json['test_taker_group_id'];
    currentItemIndex = json['current_item_index'];
    if (lst != null) {
      items = lst.map((e) => Question.fromJson(e)).toList();
    }
  }
}
