class ReviewResponse {
  ReviewResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  ReviewResponse copyWith({
    String? status,
    Data? data,
  }) {
    return ReviewResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ReviewResponse.fromJson(Map<String, dynamic> json){
    return ReviewResponse(
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
    required this.review,
  });

  final Review? review;

  Data copyWith({
    Review? review,
  }) {
    return Data(
      review: review ?? this.review,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "review": review?.toJson(),
  };

  @override
  String toString(){
    return "$review, ";
  }
}

class Review {
  Review({
    required this.id,
    required this.review,
    required this.rating,
    required this.productId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
  });

  final dynamic? id;
  final String? review;
  final dynamic? rating;
  final String? productId;
  final String? userId;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Review copyWith({
    dynamic? id,
    String? review,
    dynamic? rating,
    String? productId,
    String? userId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      id: json["id"],
      review: json["review"],
      rating: json["rating"],
      productId: json["productId"],
      userId: json["userId"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "review": review,
    "rating": rating,
    "productId": productId,
    "userId": userId,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $review, $rating, $productId, $userId, $updatedAt, $createdAt, ";
  }
}
