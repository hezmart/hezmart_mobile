class SendTokenPayload {
  SendTokenPayload({
    required this.token,
    required this.userId,
    required this.platform,
  });

  final String? token;
  final String? platform;
  final String? userId;

  SendTokenPayload copyWith({
    String? token,
    String? platform,
  }) {
    return SendTokenPayload(
      token: token ?? this.token,
      platform: platform ?? this.platform,
      userId: userId ?? this.userId,
    );
  }

  factory SendTokenPayload.fromJson(Map<String, dynamic> json){
    return SendTokenPayload(
      token: json["token"],
      platform: json["platform"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
    "platform": platform,
    "userId": userId,
  };

  @override
  String toString(){
    return "$token, $platform,$userId ";
  }
}
