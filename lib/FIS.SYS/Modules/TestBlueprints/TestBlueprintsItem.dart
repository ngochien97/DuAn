import 'package:flutter/cupertino.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Icon.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

class TestBlueprintsItem {
  String testBlueprintCode;
  String companyCode;
  DateTime createdAt;
  int createdBy;
  String description;
  bool haveChild;
  int id;
  String itemLevel;
  String itemPoint;
  String itemQuantity;
  String itemStats;
  int levelGraded;
  String testBlueprintName;
  double gpa;
  double gpaBefore;
  int improvement;
  int order;
  int status;
  int testOutlineId;
  int type;
  Stats stats1;
  Stats stats3;
  Stats stats5;
  Stats stats7;
  DateTime lastActivity;

  TestBlueprintsItem(
      {this.testBlueprintCode,
      this.companyCode,
      this.createdAt,
      this.createdBy,
      this.description,
      this.haveChild,
      this.id,
      this.itemLevel,
      this.itemPoint,
      this.itemQuantity,
      this.itemStats,
      this.levelGraded,
      this.testBlueprintName,
      this.order,
      this.status,
      this.testOutlineId,
      this.type,
      this.stats1,
      this.gpaBefore,
      this.gpa});

  TestBlueprintsItem.fromJson(Map<String, dynamic> json) {
    testBlueprintCode = json['test_blueprint_code'];
    companyCode = json['company_code'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    createdBy = json['created_by'];
    description = json['description'];
    haveChild = json['have_child'];
    id = json['id'];
    itemLevel = json['item_level'];
    itemPoint = json['item_point'];
    itemQuantity = json['item_quantity'];
    itemStats = json['item_stats'];
    levelGraded = json['level_graded'];
    testBlueprintName = json['test_blueprint_name'];
    order = json['order'];
    status = json['status'];
    testOutlineId = json['test_outline_id'];
    type = json['type'];
    gpa = json['gpa'] != null ? (json['gpa'] as num).toDouble() : null;
    improvement = json['improvement'] != null
        ? (json['improvement'] as num).toInt()
        : null;
    gpaBefore = json['gpa_before'] != null
        ? (json['gpa_before'] as num).toDouble()
        : null;

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
    switch (levelGraded) {
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

  Widget get getChangeWidget {
    if ((improvement ?? 0) == 0) {
      return Text('-');
    }

    if (improvement > 0) {
      return FIcon(
        icon: FOutlinedIcons.arrow_up,
        color: [FColors.green6],
      );
    }
    return FIcon(
      icon: FOutlinedIcons.arrow_down,
      color: [FColors.red6],
    );
  }
}

class Stats {
  int correctAnswerCount;
  int itemCount;
  int sumPoint;
  int sumPointMax;

  Stats(
      {this.correctAnswerCount,
      this.itemCount,
      this.sumPoint,
      this.sumPointMax});

  Stats.fromJson(Map<String, dynamic> json) {
    correctAnswerCount = json['correct_answer_count'];
    itemCount = json['item_count'];
    sumPoint = json['sum_point'];
    sumPointMax = json['sum_point_max'];
  }
}
