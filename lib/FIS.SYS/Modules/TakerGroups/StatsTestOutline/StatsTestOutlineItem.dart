import 'package:khao_thi_gv/FIS.SYS/Modules/TestBlueprints/TestBlueprintsItem.dart';

class StatsTestOutlineItem {
  String code;
  String companyCode;
  String createdAt;
  int createdBy;
  String description;
  String descriptionHtml;
  bool haveChild;
  int id;
  String itemLevel;
  String itemPoint;
  String itemQuantity;
  String itemStats;
  int level;
  String name;
  int order;
  String requirementsHtml;
  int status;
  int testOutlineId;
  int type;
  Stats stats1;
  Stats stats3;
  Stats stats5;
  Stats stats7;
  DateTime lastActivity;

  StatsTestOutlineItem(
      {this.code,
      this.companyCode,
      this.createdAt,
      this.createdBy,
      this.description,
      this.descriptionHtml,
      this.haveChild,
      this.id,
      this.itemLevel,
      this.itemPoint,
      this.itemQuantity,
      this.itemStats,
      this.level,
      this.name,
      this.order,
      this.requirementsHtml,
      this.status,
      this.testOutlineId,
      this.type,
      this.stats1});

  StatsTestOutlineItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    companyCode = json['company_code'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    description = json['description'];
    descriptionHtml = json['description_html'];
    haveChild = json['have_child'];
    id = json['id'];
    itemLevel = json['item_level'];
    itemPoint = json['item_point'];
    itemQuantity = json['item_quantity'];
    itemStats = json['item_stats'];
    level = json['level'];
    name = json['name'];
    order = json['order'];
    requirementsHtml = json['requirements_html'];
    status = json['status'];
    testOutlineId = json['test_outline_id'];
    type = json['type'];
    stats1 = json['data'] != null && json['data']['1'] != null
        ? Stats.fromJson(json['data']['1'])
        : null;
    stats3 = json['data'] != null && json['data']['3'] != null
        ? Stats.fromJson(json['data']['3'])
        : null;
    stats5 = json['data'] != null && json['data']['5'] != null
        ? Stats.fromJson(json['data']['5'])
        : null;
    stats7 = json['data'] != null && json['data']['7'] != null
        ? Stats.fromJson(json['data']['7'])
        : null;
    lastActivity = json['last_activity'] != null
        ? DateTime.parse(json['last_activity'])
        : null;
  }

  String get txtLevelGraded {
    switch (level) {
      case 1:
        return 'biết';
      case 3:
        return 'hiểu';
      case 5:
        return 'vận dụng';
      case 7:
        return 'vận dụng cao';
        break;
      case 0:
      default:
        return '-';
    }
  }
}
