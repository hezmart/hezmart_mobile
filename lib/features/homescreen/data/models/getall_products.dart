class GetAllProductsResponse {
  GetAllProductsResponse({
    required this.status,
    required this.result,
    required this.pagination,
    required this.data,
  });

  final String? status;
  final int? result;
  final Pagination? pagination;
  final Data? data;

  GetAllProductsResponse copyWith({
    String? status,
    int? result,
    Pagination? pagination,
    Data? data,
  }) {
    return GetAllProductsResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory GetAllProductsResponse.fromJson(Map<String, dynamic> json){
    return GetAllProductsResponse(
      status: json["status"],
      result: json["result"],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result,
    "pagination": pagination?.toJson(),
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $result, $pagination, $data, ";
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
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.user,
  });

  final List<String> images;
  final List<dynamic> shippingCountries;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final User? user;

  Product copyWith({
    List<String>? images,
    List<dynamic>? shippingCountries,
    dynamic? id,
    String? name,
    String? description,
    String? price,
    String? discountPrice,
    String? weight,
    double? ratingsAverage,
    dynamic? ratingsQuantity,
    bool? isDigital,
    String? seoTitle,
    String? seoDescription,
    bool? taxable,
    String? coverImage,
    dynamic? categoryId,
    dynamic? subCategoryId,
    dynamic? userId,
    String? status,
    String? slug,
    dynamic? stockQuantity,
    dynamic? likesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
    User? user,
  }) {
    return Product(
      images: images ?? this.images,
      shippingCountries: shippingCountries ?? this.shippingCountries,
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
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "images": images.map((x) => x).toList(),
    "shippingCountries": shippingCountries.map((x) => x).toList(),
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
    "user": user?.toJson(),
  };

  @override
  String toString(){
    return "$images, $shippingCountries, $id, $name, $description, $price, $discountPrice, $weight, $ratingsAverage, $ratingsQuantity, $isDigital, $seoTitle, $seoDescription, $taxable, $coverImage, $categoryId, $subCategoryId, $userId, $status, $slug, $stockQuantity, $likesCount, $createdAt, $updatedAt, $category, $user, ";
  }
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  final String? name;
  final int? id;

  Category copyWith({
    String? name,
    int? id,
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
  final int? id;

  User copyWith({
    String? businessName,
    int? id,
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

class Pagination {
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.nextPage,
    required this.prevPage,
  });

  final int? totalItems;
  final int? currentPage;
  final int? totalPages;
  final int? perPage;
  final dynamic nextPage;
  final dynamic prevPage;

  Pagination copyWith({
    int? totalItems,
    int? currentPage,
    int? totalPages,
    int? perPage,
    dynamic? nextPage,
    dynamic? prevPage,
  }) {
    return Pagination(
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      perPage: perPage ?? this.perPage,
      nextPage: nextPage ?? this.nextPage,
      prevPage: prevPage ?? this.prevPage,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      totalItems: json["totalItems"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      perPage: json["perPage"],
      nextPage: json["nextPage"],
      prevPage: json["prevPage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "perPage": perPage,
    "nextPage": nextPage,
    "prevPage": prevPage,
  };

  @override
  String toString(){
    return "$totalItems, $currentPage, $totalPages, $perPage, $nextPage, $prevPage, ";
  }
}
