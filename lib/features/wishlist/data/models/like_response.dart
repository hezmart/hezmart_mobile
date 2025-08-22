class ItemlikeResponse {
  ItemlikeResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  ItemlikeResponse copyWith({
    String? status,
    Data? data,
  }) {
    return ItemlikeResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ItemlikeResponse.fromJson(Map<String, dynamic> json){
    return ItemlikeResponse(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $data, ";
  }
}

class Data {
  Data({
    required this.liked,
    required this.likesCount,
  });

  final bool? liked;
  final dynamic? likesCount;

  Data copyWith({
    bool? liked,
    dynamic? likesCount,
  }) {
    return Data(
      liked: liked ?? this.liked,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      liked: json["liked"],
      likesCount: json["likesCount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "liked": liked,
    "likesCount": likesCount,
  };

  @override
  String toString(){
    return "$liked, $likesCount, ";
  }
}
