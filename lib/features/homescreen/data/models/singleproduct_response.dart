class SingleProductsResponse {
  SingleProductsResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  SingleProductsResponse copyWith({
    String? status,
    Data? data,
  }) {
    return SingleProductsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory SingleProductsResponse.fromJson(Map<String, dynamic> json){
    return SingleProductsResponse(
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
    required this.product,
  });

  final Product? product;

  Data copyWith({
    Product? product,
  }) {
    return Data(
      product: product ?? this.product,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
  };

  @override
  String toString(){
    return "$product, ";
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
    required this.subCategory,
    required this.user,
    required this.reviews,
    required this.tags,
    required this.options,
  });

  final List<dynamic> images;
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
  final Category? subCategory;
  final User? user;
  final List<dynamic> reviews;
  final List<dynamic> tags;
  final List<Option> options;

  Product copyWith({
    List<dynamic>? images,
    List<dynamic>? shippingCountries,
    dynamic? id,
    String? name,
    String? description,
    String? price,
    String? discountPrice,
    String? weight,
    dynamic? ratingsAverage,
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
    Category? subCategory,
    User? user,
    List<dynamic>? reviews,
    List<dynamic>? tags,
    List<Option>? options,
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
      subCategory: subCategory ?? this.subCategory,
      user: user ?? this.user,
      reviews: reviews ?? this.reviews,
      tags: tags ?? this.tags,
      options: options ?? this.options,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
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
      subCategory: json["subCategory"] == null ? null : Category.fromJson(json["subCategory"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
      options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
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
    "subCategory": subCategory?.toJson(),
    "user": user?.toJson(),
    "reviews": reviews.map((x) => x).toList(),
    "tags": tags.map((x) => x).toList(),
    "options": options.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$images, $shippingCountries, $id, $name, $description, $price, $discountPrice, $weight, $ratingsAverage, $ratingsQuantity, $isDigital, $seoTitle, $seoDescription, $taxable, $coverImage, $categoryId, $subCategoryId, $userId, $status, $slug, $stockQuantity, $likesCount, $createdAt, $updatedAt, $category, $subCategory, $user, $reviews, $tags, $options, ";
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final dynamic? id;
  final String? name;

  Category copyWith({
    dynamic? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  String toString(){
    return "$id, $name, ";
  }
}

class Option {
  Option({
    required this.id,
    required this.name,
    required this.values,
  });

  final dynamic? id;
  final String? name;
  final List<Value> values;

  Option copyWith({
    dynamic? id,
    String? name,
    List<Value>? values,
  }) {
    return Option(
      id: id ?? this.id,
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }

  factory Option.fromJson(Map<String, dynamic> json){
    return Option(
      id: json["id"],
      name: json["name"],
      values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "values": values.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $values, ";
  }
}

class Value {
  Value({
    required this.id,
    required this.value,
  });

  final int? id;
  final String? value;

  Value copyWith({
    dynamic? id,
    String? value,
  }) {
    return Value(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  factory Value.fromJson(Map<String, dynamic> json){
    return Value(
      id: json["id"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };

  @override
  String toString(){
    return "$id, $value, ";
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.businessLogo,
  });

  final dynamic? id;
  final String? firstName;
  final String? lastName;
  final String? businessName;
  final String? businessLogo;

  User copyWith({
    dynamic? id,
    String? firstName,
    String? lastName,
    String? businessName,
    String? businessLogo,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      businessName: businessName ?? this.businessName,
      businessLogo: businessLogo ?? this.businessLogo,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      businessName: json["businessName"],
      businessLogo: json["businessLogo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "businessName": businessName,
    "businessLogo": businessLogo,
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $businessName, $businessLogo, ";
  }
}
