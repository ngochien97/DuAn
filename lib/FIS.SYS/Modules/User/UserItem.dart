class UserItem {
  int id;
  String companyCode;
  String email;
  String fullName;
  int roleId;
  bool isRoot;
  bool isAdmin;
  bool isManager;
  String phone;
  String address;
  String companyName;

  UserItem({
    this.id,
    this.companyCode,
    this.email,
    this.fullName,
    this.roleId,
    this.isRoot,
    this.isAdmin,
    this.isManager,
    this.phone,
    this.address,
    this.companyName,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    final user = UserItem(
      id: json['id'],
      companyCode: json['company_code'],
      email: json['email'],
      fullName: json['full_name'],
      roleId: (json['role_id'] as num)?.toInt(),
      isRoot: json['is_root'],
      isAdmin: json['is_admin'],
      isManager: json['is_manager'],
      phone: json['phone'],
      address: json['address'],
      companyName: json['company_name'],
    );

    return user;
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'company_code': companyCode,
        'company_name': companyName,
        'email': email,
        'full_name': fullName,
        'role_id': roleId,
        'is_root': isRoot,
        'is_admin': isAdmin,
        'is_manager': isManager,
        'phone': phone,
        'address': address,
      };
}
