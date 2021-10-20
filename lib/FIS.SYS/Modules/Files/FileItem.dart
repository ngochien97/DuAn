export '../BaseSimple.dart';
import 'dart:typed_data';
import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';

class FileItem extends BaseItem {
  String documentId;
  String fileId;
  String filename;
  String comEmail;
  Map<String, dynamic> status;
  String uploadUser;
  DateTime uploadDate;
  String docUri;
  String previewDocUri;
  String oriDocUri;
  String previewOriDocUri;
  Uint8List imgBytes;
  bool isSelected;

  FileItem({
    this.documentId,
    this.fileId,
    this.filename,
    this.comEmail,
    this.status,
    this.uploadUser,
    this.uploadDate,
    this.docUri,
    this.previewDocUri,
    this.oriDocUri,
    this.previewOriDocUri,
    this.isSelected,
    this.imgBytes,
  });

// 0: '',
// 1: '',
// 2: '',
// 3: ''

  List<Map<String, dynamic>> statusCode = [
    {
      'code': 0,
      'text': 'Chờ nhận dạng',
      'color': FColors.orange6,
      'backGround': FColors.volcano1,
      'icon': FOutlinedIcons.clock_circle,
    },
    {
      'code': 1,
      'text': 'Đã nhận dạng',
      'color': FColors.green6,
      'backGround': FColors.green1,
      'icon': FOutlinedIcons.check,
    },
    {
      'code': 2,
      'text': 'Không thể nhận dạng',
      'color': FColors.red6,
      'backGround': FColors.red1,
      'icon': FFilledIcons.warning,
    },
    {
      'code': 3,
      'text': 'Đã xóa',
      'color': FColors.red6,
      'backGround': FColors.red1,
      'icon': FFilledIcons.delete,
    },
    // {
    //   'code': 4,
    //   'text': 'Cảnh báo trùng',
    //   'color': FColors.red6,
    //   'backGround': FColors.red1,
    //   'icon': FFilledIcons.warning,
    // }
  ];

  FileItem.fromJson(Map<String, dynamic> json) {
    documentId = json["_id"]["\$oid"];
    filename = json["filename"];
    comEmail = json["comEmail"];
    status = statusCode[json["status"]];
    uploadUser = json["uploadUser"];
    uploadDate =
        DateTime.fromMillisecondsSinceEpoch(json["uploadDate"]["\$date"]);
  }
}
