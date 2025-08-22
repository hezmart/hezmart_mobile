class DeleteItemsResponse {
  DeleteItemsResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  DeleteItemsResponse copyWith({
    String? status,
    Data? data,
  }) {
    return DeleteItemsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory DeleteItemsResponse.fromJson(Map<String, dynamic> json){
    return DeleteItemsResponse(
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
    required this.message,
    required this.summary,
  });

  final String? message;
  final Summary? summary;

  Data copyWith({
    String? message,
    Summary? summary,
  }) {
    return Data(
      message: message ?? this.message,
      summary: summary ?? this.summary,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      message: json["message"],
      summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "summary": summary?.toJson(),
  };

  @override
  String toString(){
    return "$message, $summary, ";
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

