class CartItemsResponse {
  CartItemsResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  CartItemsResponse copyWith({
    String? status,
    Data? data,
  }) {
    return CartItemsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory CartItemsResponse.fromJson(Map<String, dynamic> json){
    return CartItemsResponse(
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
    required this.items,
    required this.summary,
    required this.shippingOptions,
    required this.appliedCoupon,
  });

  final List<Item> items;
  final Summary? summary;
  final List<ShippingOption> shippingOptions;
  final dynamic appliedCoupon;

  Data copyWith({
    List<Item>? items,
    Summary? summary,
    List<ShippingOption>? shippingOptions,
    dynamic? appliedCoupon,
  }) {
    return Data(
      items: items ?? this.items,
      summary: summary ?? this.summary,
      shippingOptions: shippingOptions ?? this.shippingOptions,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
      shippingOptions: json["shippingOptions"] == null ? [] : List<ShippingOption>.from(json["shippingOptions"]!.map((x) => ShippingOption.fromJson(x))),
      appliedCoupon: json["appliedCoupon"],
    );
  }

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x?.toJson()).toList(),
    "summary": summary?.toJson(),
    "shippingOptions": shippingOptions.map((x) => x?.toJson()).toList(),
    "appliedCoupon": appliedCoupon,
  };

  @override
  String toString(){
    return "$items, $summary, $shippingOptions, $appliedCoupon, ";
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
    required this.available,
  });

  final SelectedOptions? selectedOptions;
  final dynamic? id;
  final dynamic? cartId;
  final dynamic? productId;
  final dynamic? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final bool? available;

  Item copyWith({
    SelectedOptions? selectedOptions,
    dynamic? id,
    dynamic? cartId,
    dynamic? productId,
    dynamic? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
    bool? available,
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
      available: available ?? this.available,
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
      available: json["available"],
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
    "available": available,
  };

  @override
  String toString(){
    return "$selectedOptions, $id, $cartId, $productId, $quantity, $createdAt, $updatedAt, $product, $available, ";
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.coverImage,
    required this.discountPrice,
    required this.stockQuantity,
  });

  final dynamic? id;
  final String? name;
  final String? price;
  final String? coverImage;
  final String? discountPrice;
  final dynamic? stockQuantity;

  Product copyWith({
    dynamic? id,
    String? name,
    String? price,
    String? coverImage,
    String? discountPrice,
    dynamic? stockQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      coverImage: coverImage ?? this.coverImage,
      discountPrice: discountPrice ?? this.discountPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      coverImage: json["coverImage"],
      discountPrice: json["discountPrice"],
      stockQuantity: json["stockQuantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "coverImage": coverImage,
    "discountPrice": discountPrice,
    "stockQuantity": stockQuantity,
  };

  @override
  String toString(){
    return "$id, $name, $price, $coverImage, $discountPrice, $stockQuantity, ";
  }
}

class SelectedOptions {
  SelectedOptions({
    required this.size,
    required this.color,
  });

  final String? size;
  final String? color;

  SelectedOptions copyWith({
    String? size,
    String? color,
  }) {
    return SelectedOptions(
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  factory SelectedOptions.fromJson(Map<String, dynamic> json){
    return SelectedOptions(
      size: json["size"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() => {
    "size": size,
    "color": color,
  };

  @override
  String toString(){
    return "$size, $color, ";
  }
}

class ShippingOption {
  ShippingOption({
    required this.id,
    required this.name,
    required this.cost,
    required this.estimatedDays,
  });

  final String? id;
  final String? name;
  final dynamic? cost;
  final String? estimatedDays;

  ShippingOption copyWith({
    String? id,
    String? name,
    dynamic? cost,
    String? estimatedDays,
  }) {
    return ShippingOption(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      estimatedDays: estimatedDays ?? this.estimatedDays,
    );
  }

  factory ShippingOption.fromJson(Map<String, dynamic> json){
    return ShippingOption(
      id: json["id"],
      name: json["name"],
      cost: json["cost"],
      estimatedDays: json["estimatedDays"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cost": cost,
    "estimatedDays": estimatedDays,
  };

  @override
  String toString(){
    return "$id, $name, $cost, $estimatedDays, ";
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
