export '../BaseSimple.dart';

import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class DocumentItem extends BaseItem {
  int companyId;
  int fileId;
  String fileName;
  String status;
  String img;
  String byName;
  String date;

  DocumentItem(
      {this.companyId,
      this.fileId,
      this.fileName,
      this.status,
      this.img,
      this.byName,
      this.date});

  DocumentItem.empty();
}

final List<DocumentItem> docs = [
  DocumentItem(
      fileId: 0,
      fileName: 'Hạ tầng máy chủ cho dự án FDA Thuế',
      status: 'ok',
      img: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
      byName: 'Upload by HoangNL',
      date: '28/11/2020'),
  DocumentItem(
      fileId: 0,
      fileName: 'Hạ tầng máy chủ cho dự án FDA Thuế',
      status: 'ok',
      img: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
      byName: 'Upload by HoangNL',
      date: '28/11/2020'),
  DocumentItem(
      fileId: 0,
      fileName: 'Hạ tầng máy chủ cho dự án FDA Thuế',
      status: 'ok',
      img: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
      byName: 'Upload by HoangNL',
      date: '28/11/2020'),
  DocumentItem(
      fileId: 0,
      fileName: 'Hạ tầng máy chủ cho dự án FDA Thuế',
      status: 'ok',
      img: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
      byName: 'Upload by HoangNL',
      date: '28/11/2020'),
  DocumentItem(
      fileId: 0,
      fileName: 'Hạ tầng máy chủ cho dự án FDA Thuế',
      status: 'ok',
      img: 'lib/FIS.SYS/Assets/images/ImgDocs.png',
      byName: 'Upload by HoangNL',
      date: '28/11/2020'),
];
