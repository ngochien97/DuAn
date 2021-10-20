class User {
  String id;
  String email;
  String fullName;
  String phoneNumber;
  String orgId;
  String avatarBase64;

  User({
    this.id,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.orgId,
    this.avatarBase64,
  });

  Map<String, dynamic> toJson() => {
        'userId': id,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'orgId': orgId,
        'avatarBase64': avatarBase64,
      };
}
