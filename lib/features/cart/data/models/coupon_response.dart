class CouponResponse {
  CouponResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  CouponResponse copyWith({
    String? status,
    Data? data,
  }) {
    return CouponResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory CouponResponse.fromJson(Map<String, dynamic> json){
    return CouponResponse(
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
    required this.appliedCoupon,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.itemCount,
    required this.items,
  });

  final String? appliedCoupon;
  final String? discount;
  final num? subtotal;
  final num? total;
  final num? itemCount;
  final List<Item> items;

  Data copyWith({
    String? appliedCoupon,
    String? discount,
    num? subtotal,
    num? total,
    num? itemCount,
    List<Item>? items,
  }) {
    return Data(
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
      discount: discount ?? this.discount,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      itemCount: itemCount ?? this.itemCount,
      items: items ?? this.items,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      appliedCoupon: json["appliedCoupon"],
      discount: json["discount"],
      subtotal: json["subtotal"],
      total: json["total"],
      itemCount: json["itemCount"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "appliedCoupon": appliedCoupon,
    "discount": discount,
    "subtotal": subtotal,
    "total": total,
    "itemCount": itemCount,
    "items": items.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$appliedCoupon, $discount, $subtotal, $total, $itemCount, $items, ";
  }
}

class Item {
  Item({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });

  final int? id;
  final num? productId;
  final String? name;
  final String? price;
  final num? quantity;
  final num? total;

  Item copyWith({
    int? id,
    num? productId,
    String? name,
    String? price,
    num? quantity,
    num? total,
  }) {
    return Item(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      productId: json["productId"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "name": name,
    "price": price,
    "quantity": quantity,
    "total": total,
  };

  @override
  String toString(){
    return "$id, $productId, $name, $price, $quantity, $total, ";
  }
}
