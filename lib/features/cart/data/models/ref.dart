class PaymentRefResponse {
  PaymentRefResponse({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  PaymentRefResponse copyWith({
    String? status,
    String? message,
  }) {
    return PaymentRefResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory PaymentRefResponse.fromJson(Map<String, dynamic> json){
    return PaymentRefResponse(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

  @override
  String toString(){
    return "$status, $message, ";
  }
}
