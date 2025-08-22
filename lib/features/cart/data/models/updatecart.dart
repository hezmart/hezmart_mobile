class UpdateCartItemsResponse {
  UpdateCartItemsResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  UpdateCartItemsResponse copyWith({
    String? status,
    Data? data,
  }) {
    return UpdateCartItemsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory UpdateCartItemsResponse.fromJson(Map<String, dynamic> json){
    return UpdateCartItemsResponse(
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
    required this.item,
    required this.summary,
  });

  final Item? item;
  final Summary? summary;

  Data copyWith({
    Item? item,
    Summary? summary,
  }) {
    return Data(
      item: item ?? this.item,
      summary: summary ?? this.summary,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      item: json["item"] == null ? null : Item.fromJson(json["item"]),
      summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "item": item?.toJson(),
    "summary": summary?.toJson(),
  };

  @override
  String toString(){
    return "$item, $summary, ";
  }
}

class Item {
  Item({
    required this.selectedOptions,
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final SelectedOptions? selectedOptions;
  final dynamic? id;
  final dynamic? cartId;
  final dynamic? productId;
  final dynamic? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  Item copyWith({
    SelectedOptions? selectedOptions,
    dynamic? id,
    dynamic? cartId,
    dynamic? productId,
    dynamic? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) {
    return Item(
      selectedOptions: selectedOptions ?? this.selectedOptions,
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      selectedOptions: json["selectedOptions"] == null ? null : SelectedOptions.fromJson(json["selectedOptions"]),
      id: json["id"],
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "selectedOptions": selectedOptions?.toJson(),
    "id": id,
    "cartId": cartId,
    "productId": productId,
    "quantity": quantity,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };

  @override
  String toString(){
    return "$selectedOptions, $id, $cartId, $productId, $quantity, $createdAt, $updatedAt, $product, ";
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
    required this.createdAt,
    required this.updatedAt,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product copyWith({
    List<String>? images,
    List<dynamic>? shippingCountries,
    String? itemsLeftMessage,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$images, $shippingCountries, $itemsLeftMessage, $id, $name, $description, $price, $discountPrice, $weight, $ratingsAverage, $ratingsQuantity, $isDigital, $seoTitle, $seoDescription, $taxable, $coverImage, $categoryId, $subCategoryId, $userId, $status, $slug, $stockQuantity, $likesCount, $createdAt, $updatedAt, ";
  }
}

class SelectedOptions {
  SelectedOptions({required this.json});
  final Map<String,dynamic> json;

  factory SelectedOptions.fromJson(Map<String, dynamic> json){
    return SelectedOptions(
        json: json
    );
  }

  Map<String, dynamic> toJson() => {
  };

  @override
  String toString(){
    return "";
  }
}

class Summary {
  Summary({
    required this.totalItems,
    required this.subtotal,
    required this.productDiscount,
    required this.couponDiscount,
    required this.deliveryFee,
    required this.tax,
    required this.totalDiscount,
    required this.total,
  });

  final dynamic? totalItems;
  final dynamic? subtotal;
  final dynamic? productDiscount;
  final dynamic? couponDiscount;
  final dynamic? deliveryFee;
  final dynamic? tax;
  final dynamic? totalDiscount;
  final dynamic? total;

  Summary copyWith({
    dynamic? totalItems,
    dynamic? subtotal,
    dynamic? productDiscount,
    dynamic? couponDiscount,
    dynamic? deliveryFee,
    dynamic? tax,
    dynamic? totalDiscount,
    dynamic? total,
  }) {
    return Summary(
      totalItems: totalItems ?? this.totalItems,
      subtotal: subtotal ?? this.subtotal,
      productDiscount: productDiscount ?? this.productDiscount,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      total: total ?? this.total,
    );
  }

  factory Summary.fromJson(Map<String, dynamic> json){
    return Summary(
      totalItems: json["totalItems"],
      subtotal: json["subtotal"],
      productDiscount: json["productDiscount"],
      couponDiscount: json["couponDiscount"],
      deliveryFee: json["deliveryFee"],
      tax: json["tax"],
      totalDiscount: json["totalDiscount"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "subtotal": subtotal,
    "productDiscount": productDiscount,
    "couponDiscount": couponDiscount,
    "deliveryFee": deliveryFee,
    "tax": tax,
    "totalDiscount": totalDiscount,
    "total": total,
  };

  @override
  String toString(){
    return "$totalItems, $subtotal, $productDiscount, $couponDiscount, $deliveryFee, $tax, $totalDiscount, $total, ";
  }
}
