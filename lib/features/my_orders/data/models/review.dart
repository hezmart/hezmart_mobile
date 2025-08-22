class ReviewPayload {
  ReviewPayload({
    required this.review,
    required this.rating,
    required this.productId,
    required this.userId,
  });

  final String? review;
  final dynamic? rating;
  final dynamic? productId;
  final dynamic? userId;

  ReviewPayload copyWith({
    String? review,
    dynamic? rating,
    dynamic? productId,
    dynamic? userId,
  }) {
    return ReviewPayload(
      review: review ?? this.review,
      rating: rating ?? this.rating,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
    );
  }

  factory ReviewPayload.fromJson(Map<String, dynamic> json){
    return ReviewPayload(
      review: json["review"],
      rating: json["rating"],
      productId: json["productId"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "review": review,
    "rating": rating,
    "productId": productId,
    "userId": userId,
  };

  @override
  String toString(){
    return "$review, $rating, $productId, $userId, ";
  }
}
