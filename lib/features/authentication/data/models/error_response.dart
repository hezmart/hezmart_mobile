class ErrorResponse {
  ErrorResponse({
    required this.status,
    required this.message,
    required this.errors,
  });

  final String? status;
  final String? message;
  final Errors? errors;

  ErrorResponse copyWith({
    String? status,
    String? message,
    Errors? errors,
  }) {
    return ErrorResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json){
    return ErrorResponse(
      status: json["status"],
      message: json["message"],
      errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errors": errors?.toJson(),
  };

  @override
  String toString(){
    return "$status, $message, $errors, ";
  }
}

class Errors {
  Errors({
    required this.email,
  });

  final String? email;

  Errors copyWith({
    String? email,
  }) {
    return Errors(
      email: email ?? this.email,
    );
  }

  factory Errors.fromJson(Map<String, dynamic> json){
    return Errors(
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
  };

  @override
  String toString(){
    return "$email, ";
  }
}
