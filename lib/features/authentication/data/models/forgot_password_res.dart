class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  ForgotPasswordResponse copyWith({
    String? status,
    String? message,
  }) {
    return ForgotPasswordResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json){
    return ForgotPasswordResponse(
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
