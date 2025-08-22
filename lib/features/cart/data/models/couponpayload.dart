class CouponPayload {
  CouponPayload({
    required this.code,
  });

  final String? code;

  CouponPayload copyWith({
    String? code,
  }) {
    return CouponPayload(
      code: code ?? this.code,
    );
  }

  factory CouponPayload.fromJson(Map<String, dynamic> json){
    return CouponPayload(
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
