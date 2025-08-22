class ResendOtpResponse {
  ResendOtpResponse({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  ResendOtpResponse copyWith({
    String? status,
    String? message,
  }) {
    return ResendOtpResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json){
    return ResendOtpResponse(
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
