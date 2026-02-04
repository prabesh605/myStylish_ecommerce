class UserModel {
  String? id;
  String email;
  String password;
  int? pincode;
  String? address;
  String? city;
  String? state;
  String? country;
  String? accountName;
  String? bankName;
  int? bankNumber;
  String role;
  UserModel({
    this.id,
    required this.email,
    required this.password,
    this.pincode,
    this.address,
    this.city,
    this.state,
    this.country,
    this.accountName,
    this.bankName,
    this.bankNumber,
    required this.role,
  });
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json['email'],
      password: json['password'],
      pincode: json['pinCode'] ?? 0,
      address: json['address'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
      country: json['country'] ?? "",
      accountName: json['accountName'] ?? "",
      bankName: json['bankName'] ?? "",
      bankNumber: json['bankNumber'] ?? 0,
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'pinCode': pincode,
    'address': address,
    'city': city,
    'state': state,
    "country": country,
    "accountName": accountName,
    "bankName": bankName,
    "bankNumber": bankNumber,
    "role": role,
  };
}
