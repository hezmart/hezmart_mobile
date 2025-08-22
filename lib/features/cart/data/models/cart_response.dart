class AddToCartResponse {
  AddToCartResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  AddToCartResponse copyWith({
    String? status,
    Data? data,
  }) {
    return AddToCartResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory AddToCartResponse.fromJson(Map<String, dynamic> json){
    return AddToCartResponse(
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
    required this.updatedAt,
    required this.createdAt,
  });

  final SelectedOptions? selectedOptions;
  final dynamic? id;
  final dynamic? cartId;
  final dynamic? productId;
  final dynamic? quantity;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Item copyWith({
    SelectedOptions? selectedOptions,
    dynamic? id,
    dynamic? cartId,
    dynamic? productId,
    dynamic? quantity,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Item(
      selectedOptions: selectedOptions ?? this.selectedOptions,
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      selectedOptions: json["selectedOptions"] == null ? null : SelectedOptions.fromJson(json["selectedOptions"]),
      id: json["id"],
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "selectedOptions": selectedOptions?.toJson(),
    "id": id,
    "cartId": cartId,
    "productId": productId,
    "quantity": quantity,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$selectedOptions, $id, $cartId, $productId, $quantity, $updatedAt, $createdAt, ";
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
