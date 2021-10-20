import 'package:Framework/FIS.SYS/Modules/Company/CompanyItem.dart';
import 'package:flutter/foundation.dart';

class CompanyProvider with ChangeNotifier {
  List<CompanyItem> _listCompany = [];
  List<CompanyItem> _filterListCompany = [];
  CompanyItem _currentCom;

  List<CompanyItem> get getListCompany => _filterListCompany;
  CompanyItem get currentCom => _currentCom;

  void setListCompany(List<CompanyItem> listCompany) {
    _listCompany = listCompany;
    _filterListCompany = listCompany;
    notifyListeners();
  }

  void filterList(String keyword) {
    _filterListCompany = _listCompany
        .where((el) =>
            el.companyName.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void setCurrentCompany(CompanyItem currentCom) {
    _currentCom = currentCom;
  }
}
