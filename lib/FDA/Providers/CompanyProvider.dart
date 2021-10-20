import 'package:Framework/FDA/Models/Company.dart';
import 'package:flutter/foundation.dart';

class CompanyProvider with ChangeNotifier {
  List<Company> _companies = [];
  List<Company> _search = [];

  List<Company> get getCompanies => _companies;
  List<Company> get getData => _search;

  void setCompanies(List<Company> companies) {
    _companies = companies;
    _search = companies;
    notifyListeners();
  }

  void setData(List<Company> companies) {
    _search = companies;
    notifyListeners();
  }
}
