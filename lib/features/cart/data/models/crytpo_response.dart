class CryptoResponse {
  CryptoResponse({
    required this.status,
    required this.result,
    required this.data,
  });

  final String? status;
  final dynamic? result;
  final Data? data;

  CryptoResponse copyWith({
    String? status,
    dynamic? result,
    Data? data,
  }) {
    return CryptoResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      data: data ?? this.data,
    );
  }

  factory CryptoResponse.fromJson(Map<String, dynamic> json){
    return CryptoResponse(
      status: json["status"],
      result: json["result"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $result, $data, ";
  }
}

class Data {
  Data({
    required this.paymentOptions,
  });

  final List<PaymentOption> paymentOptions;

  Data copyWith({
    List<PaymentOption>? paymentOptions,
  }) {
    return Data(
      paymentOptions: paymentOptions ?? this.paymentOptions,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      paymentOptions: json["paymentOptions"] == null ? [] : List<PaymentOption>.from(json["paymentOptions"]!.map((x) => PaymentOption.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "paymentOptions": paymentOptions.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$paymentOptions, ";
  }
}

class PaymentOption {
  PaymentOption({
    required this.id,
    required this.networkName,
    required this.walletAddress,
    required this.barcode,
    required this.createdAt,
    required this.updatedAt,
  });

  final dynamic? id;
  final String? networkName;
  final String? walletAddress;
  final String? barcode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentOption copyWith({
    dynamic? id,
    String? networkName,
    String? walletAddress,
    String? barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentOption(
      id: id ?? this.id,
      networkName: networkName ?? this.networkName,
      walletAddress: walletAddress ?? this.walletAddress,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PaymentOption.fromJson(Map<String, dynamic> json){
    return PaymentOption(
      id: json["id"],
      networkName: json["networkName"],
      walletAddress: json["walletAddress"],
      barcode: json["barcode"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "networkName": networkName,
    "walletAddress": walletAddress,
    "barcode": barcode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $networkName, $walletAddress, $barcode, $createdAt, $updatedAt, ";
  }
}
