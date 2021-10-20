class Auth {
  String token;
  String refreshToken;
  DateTime expireDate = DateTime.now();

  Auth({
    this.token,
    this.refreshToken,
    this.expireDate,
  });

  Auth fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json["token"],
      refreshToken: "",
      expireDate: DateTime.now().add(Duration(hours: 2)),
    );
  }
}
