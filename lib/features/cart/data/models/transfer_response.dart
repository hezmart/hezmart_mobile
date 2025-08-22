class ConfirmOrderPickupTranferResponse {
  ConfirmOrderPickupTranferResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  ConfirmOrderPickupTranferResponse copyWith({
    String? status,
    Data? data,
  }) {
    return ConfirmOrderPickupTranferResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ConfirmOrderPickupTranferResponse.fromJson(Map<String, dynamic> json){
    return ConfirmOrderPickupTranferResponse(
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
    required this.checkoutUrl,
    required this.reference,
  });

  final String? checkoutUrl;
  final String? reference;

  Data copyWith({
    String? checkoutUrl,
    String? reference,
  }) {
    return Data(
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      reference: reference ?? this.reference,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      checkoutUrl: json["checkoutUrl"],
      reference: json["reference"],
    );
  }

  Map<String, dynamic> toJson() => {
    "checkoutUrl": checkoutUrl,
    "reference": reference,
  };

  @override
  String toString(){
    return "$checkoutUrl, $reference, ";
  }
}
