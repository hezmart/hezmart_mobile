class ForgotPasswordPayload {
  ForgotPasswordPayload({
    required this.email,
  });

  final String? email;

  ForgotPasswordPayload copyWith({
    String? email,
  }) {
    return ForgotPasswordPayload(
      email: email ?? this.email,
    );
  }

  factory ForgotPasswordPayload.fromJson(Map<String, dynamic> json){
    return ForgotPasswordPayload(
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
