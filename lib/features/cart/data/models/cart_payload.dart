class AddToCartpayload {
  AddToCartpayload({
    required this.productId,
    required this.quantity,
    required this.options,
  });

  final dynamic? productId;
  final dynamic? quantity;
  final Options? options;

  AddToCartpayload copyWith({
    dynamic? productId,
    dynamic? quantity,
    Options? options,
  }) {
    return AddToCartpayload(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      options: options ?? this.options,
    );
  }

  factory AddToCartpayload.fromJson(Map<String, dynamic> json){
    return AddToCartpayload(
      productId: json["productId"],
      quantity: json["quantity"],
      options: json["options"] == null ? null : Options.fromJson(json["options"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
    "options": options?.toJson(),
  };

  @override
  String toString(){
    return "$productId, $quantity, $options, ";
  }
}

class Options {
  Options({
    required this.size,
    required this.color,
  });

  final String? size;
  final String? color;

  Options copyWith({
    String? size,
    String? color,
  }) {
    return Options(
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  factory Options.fromJson(Map<String, dynamic> json){
    return Options(
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
