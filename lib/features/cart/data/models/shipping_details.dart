class ShippingDetailsResponse {
  ShippingDetailsResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  ShippingDetailsResponse copyWith({
    String? status,
    Data? data,
  }) {
    return ShippingDetailsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ShippingDetailsResponse.fromJson(Map<String, dynamic> json){
    return ShippingDetailsResponse(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
    required this.settings,
  });

  final Settings? settings;

  Data copyWith({
    Settings? settings,
  }) {
    return Data(
      settings: settings ?? this.settings,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
  };

  @override
  String toString(){
    return "$settings, ";
  }
}

class Settings {
  Settings({
    required this.id,
    required this.doorDeliveryEnabled,
    required this.pickupEnabled,
    required this.freeShippingEnabled,
    required this.freeShippingMinAmount,
    required this.isActive,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic? id;
  final bool? doorDeliveryEnabled;
  final bool? pickupEnabled;
  final bool? freeShippingEnabled;
  final dynamic? freeShippingMinAmount;
  final bool? isActive;
  final dynamic? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Settings copyWith({
    dynamic? id,
    bool? doorDeliveryEnabled,
    bool? pickupEnabled,
    bool? freeShippingEnabled,
    dynamic? freeShippingMinAmount,
    bool? isActive,
    dynamic? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Settings(
      id: id ?? this.id,
      doorDeliveryEnabled: doorDeliveryEnabled ?? this.doorDeliveryEnabled,
      pickupEnabled: pickupEnabled ?? this.pickupEnabled,
      freeShippingEnabled: freeShippingEnabled ?? this.freeShippingEnabled,
      freeShippingMinAmount: freeShippingMinAmount ?? this.freeShippingMinAmount,
      isActive: isActive ?? this.isActive,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json){
    return Settings(
      id: json["id"],
      doorDeliveryEnabled: json["doorDeliveryEnabled"],
      pickupEnabled: json["pickupEnabled"],
      freeShippingEnabled: json["freeShippingEnabled"],
      freeShippingMinAmount: json["freeShippingMinAmount"],
      isActive: json["isActive"],
      updatedBy: json["updatedBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "doorDeliveryEnabled": doorDeliveryEnabled,
    "pickupEnabled": pickupEnabled,
    "freeShippingEnabled": freeShippingEnabled,
    "freeShippingMinAmount": freeShippingMinAmount,
    "isActive": isActive,
    "updatedBy": updatedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $doorDeliveryEnabled, $pickupEnabled, $freeShippingEnabled, $freeShippingMinAmount, $isActive, $updatedBy, $createdAt, $updatedAt, ";
  }
}
