import 'package:flutter/material.dart';

import '../../ConfigKhaoThi.dart';
import '../DA/TakerGroupDA.dart';
import '../TakerGroup.dart';

class TakerGroupProvider extends ChangeNotifier {
  static const pageSize = 5;
  String txtSearch = '';
  int pageId = 0;
  bool isLoading = false;
  List<TakerGroup> groups = <TakerGroup>[];
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;
  // String _url = ConfigAPI.testTakerGroupActived;

  String url = ConfigAPI.testTakerGroupActived;

  Future<bool> loadMoreData() async {
    if (isLoading) {
      return false;
    }
    isLoading = true;

    pageId++;
    final data = await takerGroupDA.gettestTakerGroupSearch(
        url, txtSearch, pageId, pageSize);
    // isLoading = false;
    if (data.code != 200) {
      pageId--;
      return false;
    }

    if (data.takerGroups.isEmpty) {
      pageId--;
      return false;
    }
    groups.addAll(data.takerGroups);
    notifyListeners();
    return true;
  }

  Future<bool> loadData() async {
    if (isLoading) {
      return false;
    }
    isLoading = true;
    pageId = 1;
    try {
      final data = await takerGroupDA.gettestTakerGroupSearch(
          url, txtSearch, pageId, pageSize);
      isLoading = false;
      if (data.code != 200) {
        pageId--;
        return false;
      }

      if (data.takerGroups.isEmpty) {
        pageId--;
        // return false;
      }
      groups = data.takerGroups;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> refreshData(TakerGroup group) async {
    final found = groups.where((element) => element.id == group.id).first;
    if (found != null) {
      found.status = group.status;
      found.timeLimit = group.timeLimit;
      found.fromTime = group.fromTime;
      found.dueTime = group.dueTime;
      found.toTime = group.toTime;
      found.name = group.name;
      found.controlMode = group.controlMode;
      found.takerCount = group.takerCount;
      found.codeProctor1 = group.codeProctor1;
      found.codeProctor2 = group.codeProctor2;
      found.takerSubmitCount = group.takerSubmitCount;
    }

    notifyListeners();
    return true;
  }

  Future<bool> removeGroup(TakerGroup group) async {
    groups = groups.where((element) => element.id != group.id).toList();

    notifyListeners();
    return true;
  }
}
