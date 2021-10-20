import 'dart:typed_data';

import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileDA.dart';
import 'package:flutter/foundation.dart';
import 'package:Framework/FIS.SYS/Modules/Files/FileItem.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class FileProvider with ChangeNotifier {
  List<FileItem> _listDocs = [];
  List<FileItem> _filterDocs = [];
  List<FileItem> _recentDocs = [];
  FileDA _fileDA = FileDA();

  List<FileItem> get getListDocs => _filterDocs;
  List<FileItem> get getListRecent => _recentDocs;

  void setListDocs(List<FileItem> listDocs) {
    _listDocs = listDocs;
    _filterDocs = listDocs;
    notifyListeners();
  }

  void addDocs(List<FileItem> listDocs) {
    _filterDocs.addAll(listDocs);
    notifyListeners();
  }

  void setRecentDocs(List<FileItem> recentDocs) {
    _recentDocs = recentDocs;
    notifyListeners();
  }

  void filterList(String keyword) {
    _filterDocs = _listDocs
        .where(
            (el) => el.filename.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterListRecent(String keyword) {
    _recentDocs = _recentDocs
        .where(
            (el) => el.filename.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void setSelect(int index, bool value) {
    _recentDocs.elementAt(index).isSelected = value;
    notifyListeners();
  }

  void setPdfImage(int index, Uint8List bytes) {
    _listDocs[index].imgBytes = bytes;
    notifyListeners();
  }

  loadImage(List<FileItem> filesOrgin) async {
    bool needRender = false;
    for (var file in filesOrgin) {
      if (file.filename.toLowerCase().endsWith(".pdf") ||
          file.filename.toLowerCase().endsWith(".png") ||
          file.filename.toLowerCase().endsWith(".jpeg") ||
          file.filename.toLowerCase().endsWith(".gif")) {
        try {
          var bytes =
              await _fileDA.getFile(Config.urlFile + file.id.toString());
          final document = await PdfDocument.openData(bytes);
          final page = await document.getPage(1);
          final pageImage =
              await page.render(width: page.width, height: page.height);
          await page.close();
          file.imgBytes = pageImage.bytes;
          needRender = true;
        } catch (e) {
          print(e);
        }
      }
    }
    if (needRender) {
      notifyListeners();
    }
  }
}

// class FilesProvider with ChangeNotifier {
//   List<FileItem> files = [];
//   FileDA _fileDA = FileDA();
//   String _comEmail;
//   String _fileName;
//   String sort;
//   int page = 1;
//   int pageSize = 10;
//   bool isLoading = false;
//   int sortType = 1;

//   void setSort(int sort) {
//     notifyListeners();
//   }

//   void setComEmail(String comEmail) {
//     _comEmail = comEmail;
//   }

//   Future<void> setFileName(String fileName) async {
//     _fileName = fileName;
//     var data = await _fileDA.getAll(_comEmail, _fileName, sort, page, pageSize);
//     if (data.statusCode == 200) {
//       files = data.fileItems;
//       notifyListeners();
//       _loadImage(data.fileItems);
//     }
//     return data;
//   }

//   Future<void> setSortType(int type) async {
//     sortType = type;
//     switch (type) {
//       case 1:
//         sort = "uploadDate:desc";
//         break;
//       case 2:
//         sort = "uploadDate:asc";
//         break;
//       case 3:
//         sort = "filename:asc";
//         break;
//       case 4:
//         sort = "filename:desc";
//         break;

//       default:
//         sort = null;
//     }
//     var data = await _fileDA.getAll(_comEmail, _fileName, sort, page, pageSize);
//     if (data.statusCode == 200) {
//       files = data.fileItems;
//       notifyListeners();
//       _loadImage(data.fileItems);
//     }
//     return data;
//   }

//   Future<FilesModel> loadData() async {
//     page = 1;
//     sort = null;
//     isLoading = false;
//     _fileName = null;
//     var data = await _fileDA.getAll(_comEmail, _fileName, sort, page, pageSize);
//     if (data.statusCode == 200) {
//       files = data.fileItems;
//       notifyListeners();
//       _loadImage(data.fileItems);
//     }
//     return data;
//   }

//   Future<FilesModel> loadMoreData() async {
//     try {
//       if (isLoading) {
//         return FilesModel()..statusCode = 0;
//       }
//       isLoading = true;
//       page++;
//       var data =
//           await _fileDA.getAll(_comEmail, _fileName, sort, page, pageSize);
//       isLoading = false;
//       if (data.statusCode == 200 && data.fileItems.length > 0) {
//         files.addAll(data.fileItems);
//         notifyListeners();
//         _loadImage(data.fileItems);

//         return data;
//       }
//       page--;
//       return FilesModel()..statusCode = 0;
//     } catch (e) {
//       isLoading = false;
//     }
//   }
// void _loadImage(List<FileItem> filesOrgin) async {
//   bool needRender = false;
//   for (var file in filesOrgin) {
//     if (file.filename.toLowerCase().endsWith(".pdf") ||
//         file.filename.toLowerCase().endsWith(".png") ||
//         file.filename.toLowerCase().endsWith(".jpeg") ||
//         file.filename.toLowerCase().endsWith(".gif")) {
//       try {
//         var bytes = await _fileDA.getFile(Config.urlFile + file.id.toString());
//         final document = await PdfDocument.openData(bytes);
//         final page = await document.getPage(1);
//         final pageImage =
//             await page.render(width: page.width, height: page.height);
//         await page.close();
//         file.imgBytes = pageImage.bytes;
//         needRender = true;
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//   if (needRender) {
//     notifyListeners();
//   }
// }
// }
