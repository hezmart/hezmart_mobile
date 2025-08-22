class StationStatesResponse {
  StationStatesResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  StationStatesResponse copyWith({
    String? status,
    Data? data,
  }) {
    return StationStatesResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory StationStatesResponse.fromJson(Map<String, dynamic> json){
    return StationStatesResponse(
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
    required this.pickupLocations,
  });

  final List<PickupLocation> pickupLocations;

  Data copyWith({
    List<PickupLocation>? pickupLocations,
  }) {
    return Data(
      pickupLocations: pickupLocations ?? this.pickupLocations,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      pickupLocations: json["pickupLocations"] == null ? [] : List<PickupLocation>.from(json["pickupLocations"]!.map((x) => PickupLocation.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "pickupLocations": pickupLocations.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$pickupLocations, ";
  }
}

class PickupLocation {
  PickupLocation({
    required this.id,
    required this.state,
    required this.name,
    required this.address,
    required this.contactPhone,
    required this.fee,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic? id;
  final String? state;
  final String? name;
  final String? address;
  final String? contactPhone;
  final dynamic? fee;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PickupLocation copyWith({
    dynamic? id,
    String? state,
    String? name,
    String? address,
    String? contactPhone,
    dynamic? fee,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PickupLocation(
      id: id ?? this.id,
      state: state ?? this.state,
      name: name ?? this.name,
      address: address ?? this.address,
      contactPhone: contactPhone ?? this.contactPhone,
      fee: fee ?? this.fee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PickupLocation.fromJson(Map<String, dynamic> json){
    return PickupLocation(
      id: json["id"],
      state: json["state"],
      name: json["name"],
      address: json["address"],
      contactPhone: json["contactPhone"],
      fee: json["fee"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "name": name,
    "address": address,
    "contactPhone": contactPhone,
    "fee": fee,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $state, $name, $address, $contactPhone, $fee, $createdAt, $updatedAt, ";
  }
}
