class GooglePayload {
  GooglePayload({
    required this.token,
  });

  final String? token;


  GooglePayload copyWith({
    String? token,
    String? code,
    String? idToken,
  }) {
    return GooglePayload(
      token: token ?? this.token,
    );
  }

  factory GooglePayload.fromJson(Map<String, dynamic> json){
    return GooglePayload(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
  };

  @override
  String toString(){
    return "$token,  ";
  }
}
