import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Students/StudentItem.dart';
import '../DA/PresentDA.dart';

import '../PresentationItem.dart';
import '../PresentationModel.dart';

class PresentationProvider extends ChangeNotifier {
  static const pageSize = 4;
  int classId;
  int pageId = 1;
  int historyPageId = 1;
  bool isLoading = false;
  List<PresentationItem> presents = <PresentationItem>[];
  List<PresentationItem> history = <PresentationItem>[];
  PresentDA presentDA = PresentDA();
  List<StudentItem> students;

  void init(int classId) {
    this.classId = classId;
    isLoading = false;
    pageId = 1;
    historyPageId = 1;
    presents = [];
    history = [];
    students = [];
    notifyListeners();
  }

  Future<PresentationModel> loadData() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    pageId = 1;
    final data = await presentDA
        .getPresentationActiveByClassId(classId, pageId, pageSize, [1, 2]);
    isLoading = false;
    if (data.code == 200) {
      presents = data.presents;
    }
    notifyListeners();
    return data;
  }

  Future<PresentationModel> loadMoreData() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    pageId += 1;
    final data = await presentDA
        .getPresentationActiveByClassId(classId, pageId, pageSize, [1, 2]);
    isLoading = false;
    if (data.code == 200) {
      if (data.presents.isEmpty) {
        pageId -= 1;
        return data;
      }
      presents.addAll(data.presents);
      notifyListeners();
    } else {
      pageId -= 1;
    }

    return data;
  }

  void rebuild() {
    notifyListeners();
  }

  Future<PresentationModel> getHistoryData() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    historyPageId = 1;
    final data = await presentDA
        .getPresentationActiveByClassId(classId, pageId, pageSize, [3]);
    isLoading = false;
    if (data.code == 200) {
      history = data.presents;
    }
    notifyListeners();
    return data;
  }

  Future<PresentationModel> loadMoreDataHistory() async {
    if (isLoading) {
      return PresentationModel()..code = -1;
    }
    isLoading = true;
    historyPageId += 1;
    final data = await presentDA
        .getPresentationActiveByClassId(classId, pageId, pageSize, [3]);
    isLoading = false;
    if (data.code == 200) {
      if (data.presents.isEmpty) {
        historyPageId -= 1;
        return data;
      }
      history.addAll(data.presents);
      notifyListeners();
    } else {
      historyPageId -= 1;
    }

    return data;
  }

  Future<void> removePresent(PresentationItem present) async {
    presents = presents.where((element) => element.id != present.id).toList();
    notifyListeners();
  }
}
