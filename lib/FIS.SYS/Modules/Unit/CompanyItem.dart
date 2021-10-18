class CompanyItem {
  int id;
  String code;
  String adminEmail;
  String name;
  String contactName;
  String phone;
  String address;

  CompanyItem(
      {this.id,
      this.code,
      this.adminEmail,
      this.name,
      this.phone,
      this.address,
      this.contactName});

  factory CompanyItem.fromJson(Map<String, dynamic> json) {
    final user = CompanyItem(
      id: json['id'],
      code: json['code'],
      adminEmail: json['admin_email'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      contactName: json['contact_name'],
    );

    return user;
  }
}
