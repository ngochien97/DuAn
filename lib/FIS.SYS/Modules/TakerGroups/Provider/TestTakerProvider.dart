import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../ClassInfomation.dart';
import '../DA/TakerGroupDA.dart';
import '../TestTaker.dart';

class TestTakerProvider extends ChangeNotifier {
  static const pageSize = 20;
  int takerGroupId;
  String txtSearch = '';
  List<int> classes = <int>[];
  List<String> testForm = <String>[];
  List<ClassInfomation> classStr = <ClassInfomation>[];
  List<Tuple2<String, bool>> formCodes = <Tuple2<String, bool>>[];
  int status;
  int pageId = 0;

  bool isLoading = false;
  List<TestTaker> sutdents = <TestTaker>[];
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;

  Future<bool> loadMoreData(int id) async {
    if (isLoading) {
      return false;
    }
    pageId++;
    final classTmp =
        classStr.where((e) => e.isActive).map((e) => e.id).toList();
    final formCodesTmp =
        formCodes.where((e) => e.item2).map((e) => e.item1).toList();

    final data = await takerGroupDA.getTestTakers(
        id, txtSearch, classTmp, formCodesTmp, status, pageId, pageSize);
    if (data.code != 200) {
      pageId--;
      return false;
    }

    if (data.testTakers.isEmpty) {
      pageId--;
      return false;
    }
    sutdents.addAll(data.testTakers);
    notifyListeners();
    return true;
  }

  Future<bool> loadData(int id) async {
    if (isLoading) {
      return false;
    }
    final classTmp =
        classStr.where((e) => e.isActive).map((e) => e.id).toList();
    final formCodesTmp =
        formCodes.where((e) => e.item2).map((e) => e.item1).toList();
    final data = await takerGroupDA.getTestTakers(
        id, txtSearch, classTmp, formCodesTmp, status, 1, pageSize);
    if (data.code != 200) {
      return false;
    }

    // if (data.testTakers.length == 0) {
    //   return false;
    // }
    sutdents = data.testTakers;
    pageId = 1;
    notifyListeners();
    return true;
  }

  Future<bool> setClass(List<ClassInfomation> datas) {
    classStr = datas;
    notifyListeners();
    return Future.value(true);
  }

  bool setActiveClass(ClassInfomation data) {
    final found = classStr.where((element) => element.id == data.id).first;
    if (found != null) {
      found.isActive = !found.isActive;
      notifyListeners();
    }

    return true;
  }

  Future<bool> setFormCodes(List<Tuple2<String, bool>> datas) {
    formCodes = datas;
    notifyListeners();
    return Future.value(true);
  }

  bool setActiveFormCode(Tuple2<String, bool> data) {
    for (var i = 0; i < formCodes.length; i++) {
      if (formCodes[i].item1 == data.item1) {
        formCodes[i] = formCodes[i].withItem2(!formCodes[i].item2);
        notifyListeners();
        break;
      }
    }

    return true;
  }

  bool setActiveStatus(int status) {
    this.status = status;
    notifyListeners();
    return true;
  }

  String setFilter(String txt) {
    txtSearch = txt;
    notifyListeners();
    return txtSearch;
  }
}
