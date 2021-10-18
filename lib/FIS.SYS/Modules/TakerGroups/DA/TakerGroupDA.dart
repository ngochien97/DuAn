import 'package:intl/intl.dart';
import '../../../Core/BaseDA.dart';

import '../../ConfigKhaoThi.dart';
import '../StatModel.dart';
import '../TakerGroup.dart';
import '../TakerGroupModel.dart';
import '../TakerGroupModelSummary.dart';
import '../TakerGroupStatus.dart';
import '../TakerGroupsModel.dart';
import '../TestTakersModel.dart';

class TakerGroupDA extends BaseDA {
  factory TakerGroupDA() => _instance;

  TakerGroupDA._internal();

  static final TakerGroupDA _instance = TakerGroupDA._internal();

  static TakerGroupDA get instance => _instance;

  Future<StatModel> getStat() async {
    final url = ConfigAPI.getStat;
    return await get(url, StatModel());
  }

  Future<TakerGroupsModel> gettestTakerGroupSearch(
      String url, String filter, int pageId, int pageSize) async {
    final finalurl =
        '$url?page=$pageId&page_size=$pageSize&filter[keyword]=$filter';
    return await get(finalurl, TakerGroupsModel());
  }

  Map<String, bool> showAction(int state) {
    final map = <String, bool>{};
    for (final item in takerGroupStatusMachine) {
      if (item.state == state) {
        map[item.action] = true;
      }
    }
    return map;
  }

  Future<TakerGroupModel> takerGroupStart(TakerGroup group) async {
    final url = ConfigAPI.takerGroupStart;
    var status = TakerGroupStatusBase.dangMoKip;

    if (group.fromTime.isBefore(DateTime.now())) {
      status = TakerGroupStatusBase.dangMoKip;
    } else if (group.dueTime.isBefore(DateTime.now())) {
      status = TakerGroupStatusBase.dangThi;
    } else if (group.toTime.isBefore(DateTime.now())) {
      status = TakerGroupStatusBase.hetHanRutDe;
    }

    return await post('$url?id=${group.id}&status=$status', TakerGroupModel());
  }

  Future<TakerGroupModel> takerGroupPause(TakerGroup group) async {
    final status = TakerGroupStatusBase.tamDung;
    const url = ConfigAPI.takerGroupPause;
    return await post('$url?id=${group.id}&status=$status', TakerGroupModel());
  }

  Future<TakerGroupModel> takerGroupLock(TakerGroup group) async {
    final url = ConfigAPI.takerGroupLock;
    final status = TakerGroupStatusBase.hetHanRutDe;
    return await post('$url?id=${group.id}&status=$status', TakerGroupModel());
  }

  Future<TakerGroupModel> takerGroupStop(TakerGroup group) async {
    final url = ConfigAPI.takerGroupStop;
    final status = TakerGroupStatusBase.dangDongKip;
    return await post('$url?id=${group.id}&status=$status', TakerGroupModel());
  }

  Future<TakerGroupModel> takerGroupDelete(int id) async {
    final url = ConfigAPI.takerGroupDelete;
    return await delete('$url?id=$id', TakerGroupModel());
  }

  Future<TakerGroupModel> takerGroupRestore(int id) async {
    final url = ConfigAPI.takerGroupRestore;
    return await post('$url?id=$id', TakerGroupModel());
  }

  Future<TakerGroupSummaryModel> getSummary(int id) async {
    final url = ConfigAPI.takerGroupGetSumary;
    return await get('$url?id=$id', TakerGroupSummaryModel());
  }

  Future<TestTakersModel> getTestTakers(
    int id,
    String filter,
    List<int> classes,
    List<String> testForm,
    int status,
    int pageId,
    int pageSize,
  ) async {
    final url = ConfigAPI.takerGroupGetTestTaker;
    var classQuery = '';
    for (final item in classes) {
      // ignore: use_string_buffers
      classQuery += '&classes[]=$item';
    }
    var testFormQuery = '';

    for (final item in testForm) {
      // ignore: use_string_buffers
      testFormQuery += '&test_form_code[]=$item';
    }
    // ignore: prefer_single_quotes
    final statusStr = status == null ? '' : '&status=$status';
    return await get(
        '$url?groupId=$id${filter != "" ? "&keyword=$filter" : ""}&page=$pageId&page_size=$pageSize${classQuery != "" ? "&$classQuery" : ""}${testFormQuery != "" ? "&$testFormQuery" : ""}$statusStr',
        TestTakersModel());
  }

  Future<TakerGroupSummaryModel> classGetSumary(
      int classId, int groupId) async {
    final url = ConfigAPI.classGetSumary;
    return await get('$url?class_id=$classId&test_taker_group_id=$groupId',
        TakerGroupSummaryModel());
  }

  Future<TakerGroupModel> udpateTakerGroup(int id, DateTime fromTime,
      DateTime dueTime, DateTime toTime, int timeLimit) async {
    final url = ConfigAPI.updateTestTakerGroup;

    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    final data =
        '{"from_time":"${formatter.format(fromTime)}", "to_time":"${formatter.format(toTime)}", "due_time":"${formatter.format(dueTime)}", "time_limit":$timeLimit}';
    return await postData('$url?id=$id', data, TakerGroupModel());
  }
}
