import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';

class Document {
  String id;
  String name;
  String image;
  String companyId;
  Map<String, dynamic> status;
  String lastUpdate;
  String userUpdateId;

  Document({
    this.id,
    this.companyId,
    this.image,
    this.lastUpdate,
    this.name,
    this.status,
    this.userUpdateId,
  });

  List<Map<String, dynamic>> statusCode = [
    {
      'code': 0,
      'text': 'Chờ xử lý',
      'color': FColors.orange6,
      'backGround': FColors.volcano1,
      'icon': FOutlinedIcons.clock_circle,
    },
    {
      'code': 1,
      'text': 'Đã xác nhận',
      'color': FColors.green6,
      'backGround': FColors.green1,
      'icon': FOutlinedIcons.check,
    },
    {
      'code': 2,
      'text': 'Đã hủy bỏ',
      'color': FColors.red6,
      'backGround': FColors.red1,
      'icon': FFilledIcons.delete,
    },
    {
      'code': 3,
      'text': 'Đã xóa',
      'color': FColors.red6,
      'backGround': FColors.red1,
      'icon': FFilledIcons.delete,
    },
    {
      'code': 4,
      'text': 'Cảnh báo trùng',
      'color': FColors.red6,
      'backGround': FColors.red1,
      'icon': FFilledIcons.warning,
    }
  ];

  void getStatus(int code) {
    this.status = statusCode.elementAt(code);
  }
}
