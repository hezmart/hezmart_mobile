class SendTokenPayload {
  SendTokenPayload({
    required this.token,
    required this.platform,
  });

  final String? token;
  final String? platform;

  SendTokenPayload copyWith({
    String? token,
    String? platform,
  }) {
    return SendTokenPayload(
      token: token ?? this.token,
      platform: platform ?? this.platform,
    );
  }

  factory SendTokenPayload.fromJson(Map<String, dynamic> json){
    return SendTokenPayload(
      token: json["token"],
      platform: json["platform"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
    "platform": platform,
  };

  @override
  String toString(){
    return "$token, $platform, ";
  }
}
