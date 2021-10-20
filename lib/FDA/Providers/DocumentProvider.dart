import 'package:flutter/foundation.dart';
import 'package:Framework/FDA/Models/Document.dart';

class DocumentProvider with ChangeNotifier {
  List<Document> _documents = [];
  List<Document> _searchDocument = [];

  List<Document> get getDocuments => _documents;
  List<Document> get getDisplayDocuments => _searchDocument;
  String _sort = 'asc';
  String get getSort => _sort;

  void setDocuments(List<Document> documents) {
    _documents = documents;
    _searchDocument = documents;
    notifyListeners();
  }

  void setDisplayDocuments(List<Document> documents) {
    _searchDocument = documents;
    notifyListeners();
  }

  sortByName() {
    notifyListeners();
  }

  reverseSortByName() {
    notifyListeners();
  }

  sortByTime() {
    notifyListeners();
  }

  reverseSortByTime() {
    notifyListeners();
  }
}
