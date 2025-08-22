class ConfirmOrderPickupCryptoResponse {
  ConfirmOrderPickupCryptoResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  ConfirmOrderPickupCryptoResponse copyWith({
    String? status,
    Data? data,
  }) {
    return ConfirmOrderPickupCryptoResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ConfirmOrderPickupCryptoResponse.fromJson(Map<String, dynamic> json){
    return ConfirmOrderPickupCryptoResponse(
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
    required this.message,
  });

  final String? message;

  Data copyWith({
    String? message,
  }) {
    return Data(
      message: message ?? this.message,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
  };

  @override
  String toString(){
    return "$message, ";
  }
}
