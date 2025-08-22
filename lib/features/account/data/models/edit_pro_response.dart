import '../../../authentication/data/models/authsuccess_response.dart';

class EditprofileResponse {
  EditprofileResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final HezmartUser? data;

  EditprofileResponse copyWith({
    String? status,
    HezmartUser? data,
  }) {
    return EditprofileResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory EditprofileResponse.fromJson(Map<String, dynamic> json){
    return EditprofileResponse(
      status: json["status"],
      data: HezmartUser.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $data, ";
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

// class HezmartUser {
//   HezmartUser({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.primaryPhone,
//     required this.primaryAddress,
//     required this.state,
//     required this.photo,
//     required this.passwordChangedAt,
//     required this.role,
//     required this.status,
//     required this.isEmailVerified,
//     required this.ninNumber,
//     required this.businessName,
//     required this.businessCategoryId,
//     required this.businessLogo,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final dynamic? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? primaryPhone;
//   final String? primaryAddress;
//   final String? state;
//   final String? photo;
//   final dynamic passwordChangedAt;
//   final String? role;
//   final String? status;
//   final bool? isEmailVerified;
//   final dynamic ninNumber;
//   final dynamic businessName;
//   final dynamic businessCategoryId;
//   final dynamic businessLogo;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   HezmartUser copyWith({
//     dynamic? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? primaryPhone,
//     String? primaryAddress,
//     String? state,
//     String? photo,
//     dynamic? passwordChangedAt,
//     String? role,
//     String? status,
//     bool? isEmailVerified,
//     dynamic? ninNumber,
//     dynamic? businessName,
//     dynamic? businessCategoryId,
//     dynamic? businessLogo,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return HezmartUser(
//       id: id ?? this.id,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       primaryPhone: primaryPhone ?? this.primaryPhone,
//       primaryAddress: primaryAddress ?? this.primaryAddress,
//       state: state ?? this.state,
//       photo: photo ?? this.photo,
//       passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
//       role: role ?? this.role,
//       status: status ?? this.status,
//       isEmailVerified: isEmailVerified ?? this.isEmailVerified,
//       ninNumber: ninNumber ?? this.ninNumber,
//       businessName: businessName ?? this.businessName,
//       businessCategoryId: businessCategoryId ?? this.businessCategoryId,
//       businessLogo: businessLogo ?? this.businessLogo,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
//
//   factory HezmartUser.fromJson(Map<String, dynamic> json){
//     return HezmartUser(
//       id: json["id"],
//       firstName: json["firstName"],
//       lastName: json["lastName"],
//       email: json["email"],
//       primaryPhone: json["primaryPhone"],
//       primaryAddress: json["primaryAddress"],
//       state: json["state"],
//       photo: json["photo"],
//       passwordChangedAt: json["passwordChangedAt"],
//       role: json["role"],
//       status: json["status"],
//       isEmailVerified: json["isEmailVerified"],
//       ninNumber: json["ninNumber"],
//       businessName: json["businessName"],
//       businessCategoryId: json["businessCategoryId"],
//       businessLogo: json["businessLogo"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "firstName": firstName,
//     "lastName": lastName,
//     "email": email,
//     "primaryPhone": primaryPhone,
//     "primaryAddress": primaryAddress,
//     "state": state,
//     "photo": photo,
//     "passwordChangedAt": passwordChangedAt,
//     "role": role,
//     "status": status,
//     "isEmailVerified": isEmailVerified,
//     "ninNumber": ninNumber,
//     "businessName": businessName,
//     "businessCategoryId": businessCategoryId,
//     "businessLogo": businessLogo,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//   };
//
//   @override
//   String toString(){
//     return "$id, $firstName, $lastName, $email, $primaryPhone, $primaryAddress, $state, $photo, $passwordChangedAt, $role, $status, $isEmailVerified, $ninNumber, $businessName, $businessCategoryId, $businessLogo, $createdAt, $updatedAt, ";
//   }
// }
