import 'package:intl/intl.dart';

extension FStringExtension on String {
  // trả về 1 String mới thay thế các kí tự unicode
  // => lowercase k dấu và k có ký tự đặc biệt
  String newUnicodeToAscii() => toLowerCase()
      .replaceAll(RegExp(r'[đ]', caseSensitive: false), 'd')
      .replaceAll(RegExp(r'[í|ì|ỉ|ĩ|ị]', caseSensitive: false), 'i')
      .replaceAll(RegExp(r'[ý|ỳ|ỷ|ỹ|ỵ]', caseSensitive: false), 'y')
      .replaceAll(
          RegExp(r'[á|à|ả|ã|ạ|â|ă|ấ|ầ|ẩ|ẫ|ậ|ắ|ằ|ẳ|ẵ|ặ]', caseSensitive: false),
          'a')
      .replaceAll(RegExp(r'[é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ]', caseSensitive: false), 'e')
      .replaceAll(RegExp(r'[ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự]', caseSensitive: false), 'u')
      .replaceAll(
          RegExp(r'[ó|ò|ỏ|õ|ọ|ô|ơ|ố|ồ|ổ|ỗ|ộ|ớ|ờ|ở|ỡ|ợ]', caseSensitive: false),
          'o');

  // trả về 1 String thay thế dấu cách ' ' bằng dấu '-'
  String slug() => trim().replaceAll(' ', '-');
}

extension FDoubleExtension on double {
  // trả về 1 String theo form tiền VD: 1000 => 1,000
  String toMoney() {
    var output = toString();
    var i = output.indexOf('.');
    while (i - 3 > 0) {
      i -= 3;
      output = output.replaceFirst(output[i], ',${output[i]}', i);
    }
    return output;
  }

  // trả về 1 số double
  double toDouble(String unicode) {
    final output = double.parse(unicode);
    return output;
  }
}

extension FIntExtension on int {
  // trả về 1 số int
  int toInt(String unicode) {
    final output = int.parse(unicode);
    return output;
  }
}

extension FDateTimeExtension on DateTime {
  String format(String pattern) {
    try {
      if (this == null) {
        return '';
      }

      return DateFormat(pattern).format(this);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }
}

extension NumberToAlphbet on int {
  String toAlphabet() {
    switch (this) {
      case 1:
        return 'A';
        break;
      case 2:
        return 'B';
        break;
      case 3:
        return 'C';
        break;
      case 4:
        return 'D';
        break;
      case 5:
        return 'E';
        break;
      case 6:
        return 'F';
        break;
      case 7:
        return 'G';
        break;
      case 8:
        return 'H';
        break;
      case 9:
        return 'I';
        break;
      case 10:
        return 'J';
        break;
      case 11:
        return 'K';
        break;
      case 12:
        return 'L';
        break;
      case 13:
        return 'M';
        break;
      case 14:
        return 'N';
        break;
      case 15:
        return 'O';
        break;
      case 16:
        return 'P';
        break;
      case 17:
        return 'Q';
        break;
      case 18:
        return 'R';
        break;
      case 19:
        return 'S';
        break;
      case 20:
        return 'T';
        break;
      case 21:
        return 'U';
        break;
      case 22:
        return 'V';
        break;
      case 23:
        return 'W';
        break;
      case 24:
        return 'X';
        break;
      case 25:
        return 'Y';
        break;
      case 26:
        return 'Z';
        break;
      default:
        return '';
    }
  }
}
