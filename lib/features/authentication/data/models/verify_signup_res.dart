class VerifySignUpOtpResponse {
  VerifySignUpOtpResponse({
    required this.status,
    required this.token,
    required this.data,
  });

  final String? status;
  final String? token;
  final Data? data;

  VerifySignUpOtpResponse copyWith({
    String? status,
    String? token,
    Data? data,
  }) {
    return VerifySignUpOtpResponse(
      status: status ?? this.status,
      token: token ?? this.token,
      data: data ?? this.data,
    );
  }

  factory VerifySignUpOtpResponse.fromJson(Map<String, dynamic> json){
    return VerifySignUpOtpResponse(
      status: json["status"],
      token: json["token"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $token, $data, ";
  }
}

class Data {
  Data({
    required this.user,
  });

  final User? user;

  Data copyWith({
    User? user,
  }) {
    return Data(
      user: user ?? this.user,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };

  @override
  String toString(){
    return "$user, ";
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.primaryPhone,
    required this.primaryAddress,
    required this.state,
    required this.photo,
    required this.passwordChangedAt,
    required this.passwordResetToken,
    required this.passwordResetExpires,
    required this.role,
    required this.status,
    required this.emailVerificationCode,
    required this.emailVerificationExpires,
    required this.isEmailVerified,
    required this.ninNumber,
    required this.businessName,
    required this.businessCategoryId,
    required this.businessLogo,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? primaryPhone;
  final String? primaryAddress;
  final String? state;
  final String? photo;
  final dynamic passwordChangedAt;
  final dynamic passwordResetToken;
  final dynamic passwordResetExpires;
  final String? role;
  final String? status;
  final dynamic emailVerificationCode;
  final dynamic emailVerificationExpires;
  final bool? isEmailVerified;
  final dynamic ninNumber;
  final dynamic businessName;
  final dynamic businessCategoryId;
  final dynamic businessLogo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User copyWith({
    dynamic? id,
    String? firstName,
    String? lastName,
    String? email,
    String? primaryPhone,
    String? primaryAddress,
    String? state,
    String? photo,
    dynamic? passwordChangedAt,
    dynamic? passwordResetToken,
    dynamic? passwordResetExpires,
    String? role,
    String? status,
    dynamic? emailVerificationCode,
    dynamic? emailVerificationExpires,
    bool? isEmailVerified,
    dynamic? ninNumber,
    dynamic? businessName,
    dynamic? businessCategoryId,
    dynamic? businessLogo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      state: state ?? this.state,
      photo: photo ?? this.photo,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      passwordResetExpires: passwordResetExpires ?? this.passwordResetExpires,
      role: role ?? this.role,
      status: status ?? this.status,
      emailVerificationCode: emailVerificationCode ?? this.emailVerificationCode,
      emailVerificationExpires: emailVerificationExpires ?? this.emailVerificationExpires,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      ninNumber: ninNumber ?? this.ninNumber,
      businessName: businessName ?? this.businessName,
      businessCategoryId: businessCategoryId ?? this.businessCategoryId,
      businessLogo: businessLogo ?? this.businessLogo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      primaryPhone: json["primaryPhone"],
      primaryAddress: json["primaryAddress"],
      state: json["state"],
      photo: json["photo"],
      passwordChangedAt: json["passwordChangedAt"],
      passwordResetToken: json["passwordResetToken"],
      passwordResetExpires: json["passwordResetExpires"],
      role: json["role"],
      status: json["status"],
      emailVerificationCode: json["emailVerificationCode"],
      emailVerificationExpires: json["emailVerificationExpires"],
      isEmailVerified: json["isEmailVerified"],
      ninNumber: json["ninNumber"],
      businessName: json["businessName"],
      businessCategoryId: json["businessCategoryId"],
      businessLogo: json["businessLogo"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "primaryPhone": primaryPhone,
    "primaryAddress": primaryAddress,
    "state": state,
    "photo": photo,
    "passwordChangedAt": passwordChangedAt,
    "passwordResetToken": passwordResetToken,
    "passwordResetExpires": passwordResetExpires,
    "role": role,
    "status": status,
    "emailVerificationCode": emailVerificationCode,
    "emailVerificationExpires": emailVerificationExpires,
    "isEmailVerified": isEmailVerified,
    "ninNumber": ninNumber,
    "businessName": businessName,
    "businessCategoryId": businessCategoryId,
    "businessLogo": businessLogo,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $email, $primaryPhone, $primaryAddress, $state, $photo, $passwordChangedAt, $passwordResetToken, $passwordResetExpires, $role, $status, $emailVerificationCode, $emailVerificationExpires, $isEmailVerified, $ninNumber, $businessName, $businessCategoryId, $businessLogo, $createdAt, $updatedAt, ";
  }
}
