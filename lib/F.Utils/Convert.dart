extension FStringExtension on String {
  // trả về 1 String mới thay thế các kí tự unicode => lowercase k dấu và k có ký tự đặc biệt
  String newUnicodeToAscii() {
    return this
        .toLowerCase()
        .replaceAll(RegExp(r"[đ]", caseSensitive: false), "d")
        .replaceAll(RegExp(r"[í|ì|ỉ|ĩ|ị]", caseSensitive: false), "i")
        .replaceAll(RegExp(r"[ý|ỳ|ỷ|ỹ|ỵ]", caseSensitive: false), "y")
        .replaceAll(
            RegExp(r"[á|à|ả|ã|ạ|â|ă|ấ|ầ|ẩ|ẫ|ậ|ắ|ằ|ẳ|ẵ|ặ]",
                caseSensitive: false),
            "a")
        .replaceAll(
            RegExp(r"[é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ]", caseSensitive: false), "e")
        .replaceAll(
            RegExp(r"[ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự]", caseSensitive: false), "u")
        .replaceAll(
            RegExp(r"[ó|ò|ỏ|õ|ọ|ô|ơ|ố|ồ|ổ|ỗ|ộ|ớ|ờ|ở|ỡ|ợ]",
                caseSensitive: false),
            "o")
        .replaceAll(RegExp(r"[^\s\w-]", caseSensitive: false), "");
  }

  // trả về 1 String thay thế dấu cách " " bằng dấu "-"
  String slug() {
    return this.trim().replaceAll(" ", "-");
  }
}

extension FDoubleExtension on double {
  // trả về 1 String theo form tiền VD: 1000 => 1,000
  String toMoney() {
    String output = this.toString();
    int i = output.indexOf('.');
    while (i - 3 > 0) {
      i -= 3;
      output = output.replaceFirst(output[i], ',' + output[i], i);
    }
    return output;
  }

  // trả về 1 số double
  double toDouble(String unicode) {
    double output = double.parse(unicode);
    return output;
  }
}

extension FIntExtension on int {
  // trả về 1 số int
  int toInt(String unicode) {
    int output = int.parse(unicode);
    return output;
  }
}
