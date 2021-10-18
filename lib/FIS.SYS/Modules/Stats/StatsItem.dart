class StatsItem {
  StatsItem({
    this.count,
    this.page,
    this.pageSize,
    this.totalCount,
    this.stats,
    this.sumData,
  });

  int count;
  int page;
  int pageSize;
  int totalCount;
  List<Stat> stats;
  Map<String, SumDatum> sumData;

  factory StatsItem.fromJson(Map<String, dynamic> json) => StatsItem(
        count: json['count'],
        page: json['page'],
        pageSize: json['page_size'],
        totalCount: json['total_count'],
        stats: List<Stat>.from(json['stats'].map((x) => Stat.fromJson(x))),
        sumData: Map.from(json['sum_data'])
            .map((k, v) => MapEntry<String, SumDatum>(k, SumDatum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'page': page,
        'page_size': pageSize,
        'total_count': totalCount,
        'stats': List<dynamic>.from(stats.map((x) => x.toJson())),
        'sum_data': Map.from(sumData)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Stat {
  Stat({
    this.testBlueprintId,
    this.testBlueprintName,
    this.testBlueprintCode,
    this.levelGraded,
    this.gpa,
    this.testOutlineId,
    this.testTakerGroupId,
    this.testTakerId,
    this.data,
    this.testBlueprintParent,
    this.testBlueprintParentId,
  });

  int testBlueprintId;
  String testBlueprintName;
  String testBlueprintCode;
  int levelGraded;
  String gpa;
  int testOutlineId;
  int testTakerGroupId;
  int testTakerId;
  Map<String, Datum> data;
  TestBlueprintParent testBlueprintParent;
  int testBlueprintParentId;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        testBlueprintId: json['test_blueprint_id'],
        testBlueprintName: json['test_blueprint_name'],
        testBlueprintCode: json['test_blueprint_code'] == null
            ? null
            : json['test_blueprint_code'],
        levelGraded: json['level_graded'],
        gpa: json['gpa'],
        testOutlineId: json['test_outline_id'],
        testTakerGroupId: json['test_taker_group_id'],
        testTakerId: json['test_taker_id'],
        data: Map.from(json['data'])
            .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
        testBlueprintParent:
            TestBlueprintParent.fromJson(json['test_blueprint_parent']),
        testBlueprintParentId: json['test_blueprint_parent_id'] == null
            ? null
            : json['test_blueprint_parent_id'],
      );

  Map<String, dynamic> toJson() => {
        'test_blueprint_id': testBlueprintId,
        'test_blueprint_name': testBlueprintName,
        'test_blueprint_code':
            testBlueprintCode == null ? null : testBlueprintCode,
        'level_graded': levelGraded,
        'gpa': gpa,
        'test_outline_id': testOutlineId,
        'test_taker_group_id': testTakerGroupId,
        'test_taker_id': testTakerId,
        'data': Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        'test_blueprint_parent': testBlueprintParent.toJson(),
        'test_blueprint_parent_id':
            testBlueprintParentId == null ? null : testBlueprintParentId,
      };
}

class Datum {
  Datum({
    this.correctAnswerCount,
    this.itemCount,
    this.sumPoint,
    this.sumPointMax,
  });

  String correctAnswerCount;
  String itemCount;
  String sumPoint;
  String sumPointMax;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        correctAnswerCount: json['correct_answer_count'],
        itemCount: json['item_count'],
        sumPoint: json['sum_point'],
        sumPointMax: json['sum_point_max'],
      );

  Map<String, dynamic> toJson() => {
        'correct_answer_count': correctAnswerCount,
        'item_count': itemCount,
        'sum_point': sumPoint,
        'sum_point_max': sumPointMax,
      };
}

class TestBlueprintParent {
  TestBlueprintParent({
    this.haveChild,
    this.id,
    this.code,
    this.companyCode,
    this.createdAt,
    this.createdBy,
    this.description,
    this.descriptionHtml,
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
  });

  bool haveChild;
  int id;
  String code;
  String companyCode;
  DateTime createdAt;
  int createdBy;
  String description;
  String descriptionHtml;
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

  factory TestBlueprintParent.fromJson(Map<String, dynamic> json) =>
      TestBlueprintParent(
        haveChild: json['have_child'],
        id: json['id'],
        code: json['code'] == null ? null : json['code'],
        companyCode: json['company_code'] == null ? null : json['company_code'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        createdBy: json['created_by'] == null ? null : json['created_by'],
        description: json['description'] == null ? null : json['description'],
        descriptionHtml:
            json['description_html'] == null ? null : json['description_html'],
        itemLevel: json['item_level'] == null ? null : json['item_level'],
        itemPoint: json['item_point'] == null ? null : json['item_point'],
        itemQuantity:
            json['item_quantity'] == null ? null : json['item_quantity'],
        itemStats: json['item_stats'] == null ? null : json['item_stats'],
        level: json['level'] == null ? null : json['level'],
        name: json['name'] == null ? null : json['name'],
        order: json['order'] == null ? null : json['order'],
        requirementsHtml: json['requirements_html'] == null
            ? null
            : json['requirements_html'],
        status: json['status'] == null ? null : json['status'],
        testOutlineId:
            json['test_outline_id'] == null ? null : json['test_outline_id'],
        type: json['type'] == null ? null : json['type'],
      );

  Map<String, dynamic> toJson() => {
        'have_child': haveChild,
        'id': id,
        'code': code == null ? null : code,
        'company_code': companyCode == null ? null : companyCode,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'created_by': createdBy == null ? null : createdBy,
        'description': description == null ? null : description,
        'description_html': descriptionHtml == null ? null : descriptionHtml,
        'item_level': itemLevel == null ? null : itemLevel,
        'item_point': itemPoint == null ? null : itemPoint,
        'item_quantity': itemQuantity == null ? null : itemQuantity,
        'item_stats': itemStats == null ? null : itemStats,
        'level': level == null ? null : level,
        'name': name == null ? null : name,
        'order': order == null ? null : order,
        'requirements_html': requirementsHtml == null ? null : requirementsHtml,
        'status': status == null ? null : status,
        'test_outline_id': testOutlineId == null ? null : testOutlineId,
        'type': type == null ? null : type,
      };
}

class SumDatum {
  SumDatum({
    this.sumCorrectAnswerCount,
    this.sumItemCount,
  });

  int sumCorrectAnswerCount;
  int sumItemCount;

  factory SumDatum.fromJson(Map<String, dynamic> json) => SumDatum(
        sumCorrectAnswerCount: json['sum_correct_answer_count'],
        sumItemCount: json['sum_item_count'],
      );

  Map<String, dynamic> toJson() => {
        'sum_correct_answer_count': sumCorrectAnswerCount,
        'sum_item_count': sumItemCount,
      };
}
