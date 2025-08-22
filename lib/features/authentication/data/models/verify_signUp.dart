class VerifySignUpOtpPayload {
  VerifySignUpOtpPayload({
    required this.code,
  });

  final dynamic? code;

  VerifySignUpOtpPayload copyWith({
    dynamic? code,
  }) {
    return VerifySignUpOtpPayload(
      code: code ?? this.code,
    );
  }

  factory VerifySignUpOtpPayload.fromJson(Map<String, dynamic> json){
    return VerifySignUpOtpPayload(
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
  };

  @override
  String toString(){
    return "$code, ";
  }
}
