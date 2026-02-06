class AuthSuccessResponse {
  AuthSuccessResponse({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.data,
  });

  final String? status;
  final String? accessToken;
  final String? refreshToken;
  final Data? data;

  AuthSuccessResponse copyWith({
    String? status,
    String? accessToken,
    String? refreshToken,
    Data? data,
  }) {
    return AuthSuccessResponse(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      data: data ?? this.data,
    );
  }

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json){
    return AuthSuccessResponse(
      status: json["status"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $accessToken, $refreshToken, $data, ";
  }
}

class Data {
  Data({
    required this.user,
  });

  final HezmartUser? user;

  Data copyWith({
    HezmartUser? user,
  }) {
    return Data(
      user: user ?? this.user,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      user: json["user"] == null ? null : HezmartUser.fromJson(json["user"]),
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

class HezmartUser {
  HezmartUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.primaryPhone,
    required this.primaryAddress,
    required this.state,
    required this.photo,
    required this.passwordChangedAt,
    required this.role,
    required this.status,
    required this.isEmailVerified,
    required this.ninNumber,
    required this.businessName,
    required this.businessCategoryId,
    required this.businessLogo,
    required this.authProvider,
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
  final String? role;
  final String? status;
  final bool? isEmailVerified;
  final dynamic ninNumber;
  final dynamic businessName;
  final dynamic businessCategoryId;
  final dynamic businessLogo;
  final String? authProvider;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HezmartUser copyWith({
    dynamic? id,
    String? firstName,
    String? lastName,
    String? email,
    String? primaryPhone,
    String? primaryAddress,
    String? state,
    String? photo,
    dynamic? passwordChangedAt,
    String? role,
    String? status,
    bool? isEmailVerified,
    dynamic? ninNumber,
    dynamic? businessName,
    dynamic? businessCategoryId,
    dynamic? businessLogo,
    String? authProvider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HezmartUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      state: state ?? this.state,
      photo: photo ?? this.photo,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
      role: role ?? this.role,
      status: status ?? this.status,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      ninNumber: ninNumber ?? this.ninNumber,
      businessName: businessName ?? this.businessName,
      businessCategoryId: businessCategoryId ?? this.businessCategoryId,
      businessLogo: businessLogo ?? this.businessLogo,
      authProvider: authProvider ?? this.authProvider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory HezmartUser.fromJson(Map<String, dynamic> json){
    return HezmartUser(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      primaryPhone: json["primaryPhone"],
      primaryAddress: json["primaryAddress"],
      state: json["state"],
      photo: json["photo"],
      passwordChangedAt: json["passwordChangedAt"],
      role: json["role"],
      status: json["status"],
      isEmailVerified: json["isEmailVerified"],
      ninNumber: json["ninNumber"],
      businessName: json["businessName"],
      businessCategoryId: json["businessCategoryId"],
      businessLogo: json["businessLogo"],
      authProvider: json["authProvider"],
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
    "role": role,
    "status": status,
    "isEmailVerified": isEmailVerified,
    "ninNumber": ninNumber,
    "businessName": businessName,
    "businessCategoryId": businessCategoryId,
    "businessLogo": businessLogo,
    "authProvider": authProvider,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $email, $primaryPhone, $primaryAddress, $state, $photo, $passwordChangedAt, $role, $status, $isEmailVerified, $ninNumber, $businessName, $businessCategoryId, $businessLogo, $authProvider, $createdAt, $updatedAt, ";
  }
}
