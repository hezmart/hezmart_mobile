class MyFavouriteResponse {
  MyFavouriteResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  final String? status;
  final dynamic? results;
  final Data? data;

  MyFavouriteResponse copyWith({
    String? status,
    dynamic? results,
    Data? data,
  }) {
    return MyFavouriteResponse(
      status: status ?? this.status,
      results: results ?? this.results,
      data: data ?? this.data,
    );
  }

  factory MyFavouriteResponse.fromJson(Map<String, dynamic> json){
    return MyFavouriteResponse(
      status: json["status"],
      results: json["results"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $results, $data, ";
  }
}

class Data {
  Data({
    required this.likes,
  });

  final List<Like> likes;

  Data copyWith({
    List<Like>? likes,
  }) {
    return Data(
      likes: likes ?? this.likes,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      likes: json["likes"] == null ? [] : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "likes": likes.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$likes, ";
  }
}

class Like {
  Like({
    required this.id,
    required this.productId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final dynamic? id;
  final dynamic? productId;
  final dynamic? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  Like copyWith({
    dynamic? id,
    dynamic? productId,
    dynamic? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) {
    return Like(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }

  factory Like.fromJson(Map<String, dynamic> json){
    return Like(
      id: json["id"],
      productId: json["productId"],
      userId: json["userId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };

  @override
  String toString(){
    return "$id, $productId, $userId, $createdAt, $updatedAt, $product, ";
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.stockQuantity,
    required this.coverImage,
    required this.slug,
  });

  final dynamic? id;
  final String? name;
  final String? price;
  final String? discountPrice;
  final dynamic? stockQuantity;
  final String? coverImage;
  final String? slug;

  Product copyWith({
    dynamic? id,
    String? name,
    String? price,
    String? discountPrice,
    dynamic? stockQuantity,
    String? coverImage,
    String? slug,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      coverImage: coverImage ?? this.coverImage,
      slug: slug ?? this.slug,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      discountPrice: json["discountPrice"],
      stockQuantity: json["stockQuantity"],
      coverImage: json["coverImage"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "discountPrice": discountPrice,
    "stockQuantity": stockQuantity,
    "coverImage": coverImage,
    "slug": slug,
  };

  @override
  String toString(){
    return "$id, $name, $price, $discountPrice, $stockQuantity, $coverImage, $slug, ";
  }
}
