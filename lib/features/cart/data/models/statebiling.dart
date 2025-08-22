class StateBillingResponse {
  StateBillingResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  StateBillingResponse copyWith({
    String? status,
    Data? data,
  }) {
    return StateBillingResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory StateBillingResponse.fromJson(Map<String, dynamic> json){
    return StateBillingResponse(
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
    required this.stateFees,
  });

  final List<StateFee> stateFees;

  Data copyWith({
    List<StateFee>? stateFees,
  }) {
    return Data(
      stateFees: stateFees ?? this.stateFees,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      stateFees: json["stateFees"] == null ? [] : List<StateFee>.from(json["stateFees"]!.map((x) => StateFee.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "stateFees": stateFees.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$stateFees, ";
  }
}

class StateFee {
  StateFee({
    required this.id,
    required this.state,
    required this.fee,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic? id;
  final String? state;
  final dynamic? fee;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StateFee copyWith({
    dynamic? id,
    String? state,
    dynamic? fee,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StateFee(
      id: id ?? this.id,
      state: state ?? this.state,
      fee: fee ?? this.fee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StateFee.fromJson(Map<String, dynamic> json){
    return StateFee(
      id: json["id"],
      state: json["state"],
      fee: json["fee"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "fee": fee,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $state, $fee, $createdAt, $updatedAt, ";
  }
}
