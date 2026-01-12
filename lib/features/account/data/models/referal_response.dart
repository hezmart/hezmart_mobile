class ReferalResspomse {
  ReferalResspomse({
    required this.status,
    required this.message,
    required this.application,
  });

  final String? status;
  final String? message;
  final Application? application;

  ReferalResspomse copyWith({
    String? status,
    String? message,
    Application? application,
  }) {
    return ReferalResspomse(
      status: status ?? this.status,
      message: message ?? this.message,
      application: application ?? this.application,
    );
  }

  factory ReferalResspomse.fromJson(Map<String, dynamic> json){
    return ReferalResspomse(
      status: json["status"],
      message: json["message"],
      application: json["application"] == null ? null : Application.fromJson(json["application"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "application": application?.toJson(),
  };

  @override
  String toString(){
    return "$status, $message, $application, ";
  }
}

class Application {
  Application({
    required this.id,
    required this.name,
    required this.motive,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? motive;
  final num? userId;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Application copyWith({
    int? id,
    String? name,
    String? motive,
    num? userId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Application(
      id: id ?? this.id,
      name: name ?? this.name,
      motive: motive ?? this.motive,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Application.fromJson(Map<String, dynamic> json){
    return Application(
      id: json["id"],
      name: json["name"],
      motive: json["motive"],
      userId: json["userId"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "motive": motive,
    "userId": userId,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $name, $motive, $userId, $updatedAt, $createdAt, ";
  }
}
