class LastViewedResponse {
  LastViewedResponse({
    required this.status,
    required this.result,
    required this.data,
  });

  final String? status;
  final dynamic? result;
  final Data? data;

  LastViewedResponse copyWith({
    String? status,
    num? result,
    Data? data,
  }) {
    return LastViewedResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      data: data ?? this.data,
    );
  }

  factory LastViewedResponse.fromJson(Map<String, dynamic> json){
    return LastViewedResponse(
      status: json["status"],
      result: json["result"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $result, $data, ";
  }
}

class Data {
  Data({
    required this.products,
  });

  final List<Product> products;

  Data copyWith({
    List<Product>? products,
  }) {
    return Data(
      products: products ?? this.products,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "products": products.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$products, ";
  }
}

class Product {
  Product({
    required this.images,
    required this.shippingCountries,
    required this.itemsLeftMessage,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.weight,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.isDigital,
    required this.seoTitle,
    required this.seoDescription,
    required this.taxable,
    required this.coverImage,
    required this.categoryId,
    required this.subCategoryId,
    required this.userId,
    required this.status,
    required this.slug,
    required this.stockQuantity,
    required this.likesCount,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.user,
  });

  final List<String> images;
  final List<dynamic> shippingCountries;
  final String? itemsLeftMessage;
  final dynamic? id;
  final String? name;
  final String? description;
  final String? price;
  final String? discountPrice;
  final String? weight;
  final dynamic? ratingsAverage;
  final dynamic? ratingsQuantity;
  final bool? isDigital;
  final String? seoTitle;
  final String? seoDescription;
  final bool? taxable;
  final String? coverImage;
  final dynamic? categoryId;
  final dynamic? subCategoryId;
  final dynamic? userId;
  final String? status;
  final String? slug;
  final dynamic? stockQuantity;
  final dynamic? likesCount;
  final dynamic? viewsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final User? user;

  Product copyWith({
    List<String>? images,
    List<dynamic>? shippingCountries,
    String? itemsLeftMessage,
    int? id,
    String? name,
    String? description,
    String? price,
    String? discountPrice,
    String? weight,
    num? ratingsAverage,
    num? ratingsQuantity,
    bool? isDigital,
    String? seoTitle,
    String? seoDescription,
    bool? taxable,
    String? coverImage,
    num? categoryId,
    num? subCategoryId,
    num? userId,
    String? status,
    String? slug,
    num? stockQuantity,
    num? likesCount,
    num? viewsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
    User? user,
  }) {
    return Product(
      images: images ?? this.images,
      shippingCountries: shippingCountries ?? this.shippingCountries,
      itemsLeftMessage: itemsLeftMessage ?? this.itemsLeftMessage,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      weight: weight ?? this.weight,
      ratingsAverage: ratingsAverage ?? this.ratingsAverage,
      ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
      isDigital: isDigital ?? this.isDigital,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      taxable: taxable ?? this.taxable,
      coverImage: coverImage ?? this.coverImage,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      slug: slug ?? this.slug,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      likesCount: likesCount ?? this.likesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      user: user ?? this.user,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      shippingCountries: json["shippingCountries"] == null ? [] : List<dynamic>.from(json["shippingCountries"]!.map((x) => x)),
      itemsLeftMessage: json["itemsLeftMessage"],
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      discountPrice: json["discountPrice"],
      weight: json["weight"],
      ratingsAverage: json["ratingsAverage"],
      ratingsQuantity: json["ratingsQuantity"],
      isDigital: json["isDigital"],
      seoTitle: json["seoTitle"],
      seoDescription: json["seoDescription"],
      taxable: json["taxable"],
      coverImage: json["coverImage"],
      categoryId: json["categoryId"],
      subCategoryId: json["subCategoryId"],
      userId: json["userId"],
      status: json["status"],
      slug: json["slug"],
      stockQuantity: json["stockQuantity"],
      likesCount: json["likesCount"],
      viewsCount: json["viewsCount"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "images": images.map((x) => x).toList(),
    "shippingCountries": shippingCountries.map((x) => x).toList(),
    "itemsLeftMessage": itemsLeftMessage,
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "discountPrice": discountPrice,
    "weight": weight,
    "ratingsAverage": ratingsAverage,
    "ratingsQuantity": ratingsQuantity,
    "isDigital": isDigital,
    "seoTitle": seoTitle,
    "seoDescription": seoDescription,
    "taxable": taxable,
    "coverImage": coverImage,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "userId": userId,
    "status": status,
    "slug": slug,
    "stockQuantity": stockQuantity,
    "likesCount": likesCount,
    "viewsCount": viewsCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
    "user": user?.toJson(),
  };

  @override
  String toString(){
    return "$images, $shippingCountries, $itemsLeftMessage, $id, $name, $description, $price, $discountPrice, $weight, $ratingsAverage, $ratingsQuantity, $isDigital, $seoTitle, $seoDescription, $taxable, $coverImage, $categoryId, $subCategoryId, $userId, $status, $slug, $stockQuantity, $likesCount, $viewsCount, $createdAt, $updatedAt, $category, $user, ";
  }
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  final String? name;
  final dynamic? id;

  Category copyWith({
    String? name,
    dynamic? id,
  }) {
    return Category(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      name: json["name"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };

  @override
  String toString(){
    return "$name, $id, ";
  }
}

class User {
  User({
    required this.businessName,
    required this.id,
  });

  final String? businessName;
  final dynamic? id;

  User copyWith({
    String? businessName,
    dynamic? id,
  }) {
    return User(
      businessName: businessName ?? this.businessName,
      id: id ?? this.id,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      businessName: json["businessName"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "id": id,
  };

  @override
  String toString(){
    return "$businessName, $id, ";
  }
}
