class FlashSalesResponse {
  FlashSalesResponse({
    required this.status,
    required this.result,
    required this.pagination,
    required this.data,
  });

  final String? status;
  final num? result;
  final Pagination? pagination;
  final Data? data;

  FlashSalesResponse copyWith({
    String? status,
    num? result,
    Pagination? pagination,
    Data? data,
  }) {
    return FlashSalesResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory FlashSalesResponse.fromJson(Map<String, dynamic> json){
    return FlashSalesResponse(
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
    required this.flashSales,
    required this.category,
    required this.user,
  });

  final List<String> images;
  final List<dynamic> shippingCountries;
  final String? itemsLeftMessage;
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? discountPrice;
  final String? weight;
  final num? ratingsAverage;
  final num? ratingsQuantity;
  final bool? isDigital;
  final String? seoTitle;
  final String? seoDescription;
  final bool? taxable;
  final String? coverImage;
  final num? categoryId;
  final num? subCategoryId;
  final num? userId;
  final String? status;
  final String? slug;
  final num? stockQuantity;
  final num? likesCount;
  final num? viewsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<FlashSale> flashSales;
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
    List<FlashSale>? flashSales,
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
      flashSales: flashSales ?? this.flashSales,
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
      flashSales: json["flashSales"] == null ? [] : List<FlashSale>.from(json["flashSales"]!.map((x) => FlashSale.fromJson(x))),
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
    "flashSales": flashSales.map((x) => x?.toJson()).toList(),
    "category": category?.toJson(),
    "user": user?.toJson(),
  };

  @override
  String toString(){
    return "$images, $shippingCountries, $itemsLeftMessage, $id, $name, $description, $price, $discountPrice, $weight, $ratingsAverage, $ratingsQuantity, $isDigital, $seoTitle, $seoDescription, $taxable, $coverImage, $categoryId, $subCategoryId, $userId, $status, $slug, $stockQuantity, $likesCount, $viewsCount, $createdAt, $updatedAt, $flashSales, $category, $user, ";
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

class FlashSale {
  FlashSale({
    required this.id,
    required this.salePrice,
    required this.startTime,
    required this.endTime,
    required this.inventoryLimit,
  });

  final int? id;
  final String? salePrice;
  final DateTime? startTime;
  final DateTime? endTime;
  final num? inventoryLimit;

  FlashSale copyWith({
    int? id,
    String? salePrice,
    DateTime? startTime,
    DateTime? endTime,
    num? inventoryLimit,
  }) {
    return FlashSale(
      id: id ?? this.id,
      salePrice: salePrice ?? this.salePrice,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      inventoryLimit: inventoryLimit ?? this.inventoryLimit,
    );
  }

  factory FlashSale.fromJson(Map<String, dynamic> json){
    return FlashSale(
      id: json["id"],
      salePrice: json["salePrice"],
      startTime: DateTime.tryParse(json["startTime"] ?? ""),
      endTime: DateTime.tryParse(json["endTime"] ?? ""),
      inventoryLimit: json["inventoryLimit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "salePrice": salePrice,
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "inventoryLimit": inventoryLimit,
  };

  @override
  String toString(){
    return "$id, $salePrice, $startTime, $endTime, $inventoryLimit, ";
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

  final num? totalItems;
  final num? currentPage;
  final num? totalPages;
  final num? perPage;
  final dynamic nextPage;
  final dynamic prevPage;

  Pagination copyWith({
    num? totalItems,
    num? currentPage,
    num? totalPages,
    num? perPage,
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
