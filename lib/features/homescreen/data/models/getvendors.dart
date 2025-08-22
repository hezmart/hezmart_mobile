class GetVendorsResponse {
  GetVendorsResponse({
    required this.status,
    required this.result,
    required this.pagination,
    required this.data,
  });

  final String? status;
  final dynamic? result;
  final Pagination? pagination;
  final Data? data;

  GetVendorsResponse copyWith({
    String? status,
    dynamic? result,
    Pagination? pagination,
    Data? data,
  }) {
    return GetVendorsResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory GetVendorsResponse.fromJson(Map<String, dynamic> json){
    return GetVendorsResponse(
      status: json["status"],
      result: json["result"],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result,
    "pagination": pagination?.toJson(),
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $result, $pagination, $data, ";
  }
}

class Data {
  Data({
    required this.users,
  });

  final List<User> users;

  Data copyWith({
    List<User>? users,
  }) {
    return Data(
      users: users ?? this.users,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "users": users.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$users, ";
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
    required this.category,
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
  final String? ninNumber;
  final String? businessName;
  final int? businessCategoryId;
  final String? businessLogo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

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
    String? ninNumber,
    String? businessName,
    int? businessCategoryId,
    String? businessLogo,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
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
      category: category ?? this.category,
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
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
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
    "category": category?.toJson(),
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $email, $primaryPhone, $primaryAddress, $state, $photo, $passwordChangedAt, $passwordResetToken, $passwordResetExpires, $role, $status, $emailVerificationCode, $emailVerificationExpires, $isEmailVerified, $ninNumber, $businessName, $businessCategoryId, $businessLogo, $createdAt, $updatedAt, $category, ";
  }
}

class Category {
  Category({
    required this.name,
  });

  final String? name;

  Category copyWith({
    String? name,
  }) {
    return Category(
      name: name ?? this.name,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  @override
  String toString(){
    return "$name, ";
  }
}

class Pagination {
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.nextPage,
    required this.prevPage,
  });

  final dynamic? totalItems;
  final dynamic? currentPage;
  final dynamic? totalPages;
  final dynamic? perPage;
  final dynamic nextPage;
  final dynamic prevPage;

  Pagination copyWith({
    dynamic? totalItems,
    dynamic? currentPage,
    dynamic? totalPages,
    dynamic? perPage,
    dynamic? nextPage,
    dynamic? prevPage,
  }) {
    return Pagination(
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      perPage: perPage ?? this.perPage,
      nextPage: nextPage ?? this.nextPage,
      prevPage: prevPage ?? this.prevPage,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      totalItems: json["totalItems"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      perPage: json["perPage"],
      nextPage: json["nextPage"],
      prevPage: json["prevPage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "perPage": perPage,
    "nextPage": nextPage,
    "prevPage": prevPage,
  };

  @override
  String toString(){
    return "$totalItems, $currentPage, $totalPages, $perPage, $nextPage, $prevPage, ";
  }
}
