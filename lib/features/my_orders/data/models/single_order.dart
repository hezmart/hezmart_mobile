




class SingleOrdersResponse {
  SingleOrdersResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  SingleOrdersResponse copyWith({
    String? status,
    Data? data,
  }) {
    return SingleOrdersResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory SingleOrdersResponse.fromJson(Map<String, dynamic> json){
    return SingleOrdersResponse(
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
    required this.order,
  });

  final Order? order;

  Data copyWith({
    Order? order,
  }) {
    return Data(
      order: order ?? this.order,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
  };

  @override
  String toString(){
    return "$order, ";
  }
}

class Order {
  Order({
    required this.stateFeeDetails,
    required this.pickupStationDetails,
    required this.walletDetails,
    required this.deliveryAddress,
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.status,
    required this.subtotal,
    required this.discount,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryOption,
    required this.couponId,
    required this.couponCode,
    required this.trackingNumber,
    required this.customerNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.user,
  });

  final StateFeeDetails? stateFeeDetails;
  final PickupStationDetails? pickupStationDetails;
  final WalletDetails? walletDetails;
  final DeliveryAddress? deliveryAddress;
  final dynamic? id;
  final dynamic? userId;
  final String? orderNumber;
  final String? status;
  final String? subtotal;
  final String? discount;
  final String? deliveryFee;
  final String? tax;
  final String? total;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? deliveryOption;
  final dynamic couponId;
  final dynamic couponCode;
  final dynamic trackingNumber;
  final dynamic customerNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item> items;
  final User? user;

  Order copyWith({
    StateFeeDetails? stateFeeDetails,
    PickupStationDetails? pickupStationDetails,
    WalletDetails? walletDetails,
    DeliveryAddress? deliveryAddress,
    dynamic? id,
    dynamic? userId,
    String? orderNumber,
    String? status,
    String? subtotal,
    String? discount,
    String? deliveryFee,
    String? tax,
    String? total,
    String? paymentMethod,
    String? paymentStatus,
    String? deliveryOption,
    dynamic? couponId,
    dynamic? couponCode,
    dynamic? trackingNumber,
    dynamic? customerNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Item>? items,
    User? user,
  }) {
    return Order(
      stateFeeDetails: stateFeeDetails ?? this.stateFeeDetails,
      pickupStationDetails: pickupStationDetails ?? this.pickupStationDetails,
      walletDetails: walletDetails ?? this.walletDetails,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      couponId: couponId ?? this.couponId,
      couponCode: couponCode ?? this.couponCode,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      customerNotes: customerNotes ?? this.customerNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      user: user ?? this.user,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      stateFeeDetails: json["stateFeeDetails"] == null ? null : StateFeeDetails.fromJson(json["stateFeeDetails"]),
      pickupStationDetails: json["pickupStationDetails"] == null ? null : PickupStationDetails.fromJson(json["pickupStationDetails"]),
      walletDetails: json["walletDetails"] is Map<String, dynamic>
          ? WalletDetails.fromJson(json["walletDetails"])
          : null,

      deliveryAddress: json["deliveryAddress"] == null ? null : DeliveryAddress.fromJson(json["deliveryAddress"]),
      id: json["id"],
      userId: json["userId"],
      orderNumber: json["orderNumber"],
      status: json["status"],
      subtotal: json["subtotal"],
      discount: json["discount"],
      deliveryFee: json["deliveryFee"],
      tax: json["tax"],
      total: json["total"],
      paymentMethod: json["paymentMethod"],
      paymentStatus: json["paymentStatus"],
      deliveryOption: json["deliveryOption"],
      couponId: json["couponId"],
      couponCode: json["couponCode"],
      trackingNumber: json["trackingNumber"],
      customerNotes: json["customerNotes"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "stateFeeDetails": stateFeeDetails?.toJson(),
    "pickupStationDetails": pickupStationDetails?.toJson(),
    "walletDetails": walletDetails?.toJson(),
    "deliveryAddress": deliveryAddress?.toJson(),
    "id": id,
    "userId": userId,
    "orderNumber": orderNumber,
    "status": status,
    "subtotal": subtotal,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "tax": tax,
    "total": total,
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "deliveryOption": deliveryOption,
    "couponId": couponId,
    "couponCode": couponCode,
    "trackingNumber": trackingNumber,
    "customerNotes": customerNotes,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "items": items.map((x) => x?.toJson()).toList(),
    "user": user?.toJson(),
  };

  @override
  String toString(){
    return "$stateFeeDetails, $pickupStationDetails, $walletDetails, $deliveryAddress, $id, $userId, $orderNumber, $status, $subtotal, $discount, $deliveryFee, $tax, $total, $paymentMethod, $paymentStatus, $deliveryOption, $couponId, $couponCode, $trackingNumber, $customerNotes, $createdAt, $updatedAt, $items, $user, ";
  }
}

class DeliveryAddress {
  DeliveryAddress({
    required this.firstName,
    required this.lastName,
    required this.primaryPhone,
    required this.state,
    required this.primaryAddress,
    required this.email,
  });

  final String? firstName;
  final String? lastName;
  final String? primaryPhone;
  final String? state;
  final String? primaryAddress;
  final String? email;

  DeliveryAddress copyWith({
    String? firstName,
    String? lastName,
    String? primaryPhone,
    String? state,
    String? primaryAddress,
    String? email,
  }) {
    return DeliveryAddress(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      state: state ?? this.state,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      email: email ?? this.email,
    );
  }

  factory DeliveryAddress.fromJson(Map<String, dynamic> json){
    return DeliveryAddress(
      firstName: json["firstName"],
      lastName: json["lastName"],
      primaryPhone: json["primaryPhone"],
      state: json["state"],
      primaryAddress: json["primaryAddress"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "primaryPhone": primaryPhone,
    "state": state,
    "primaryAddress": primaryAddress,
    "email": email,
  };

  @override
  String toString(){
    return "$firstName, $lastName, $primaryPhone, $state, $primaryAddress, $email, ";
  }
}

class Item {
  Item({
    required this.selectedOptions,
    required this.id,
    required this.orderId,
    required this.productId,
    required this.vendorId,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    required this.fulfillmentStatus,
    required this.shippedAt,
    required this.deliveredAt,
    required this.receivedAt,
    required this.trackingNumber,
    required this.vendorNotes,
    required this.customerNotes,
    required this.cancellationReason,
    required this.returnReason,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.vendor,
  });

  final SelectedOptions? selectedOptions;
  final dynamic? id;
  final dynamic? orderId;
  final dynamic? productId;
  final dynamic? vendorId;
  final dynamic? quantity;
  final String? price;
  final String? discountPrice;
  final String? fulfillmentStatus;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final DateTime? receivedAt;
  final dynamic trackingNumber;
  final dynamic vendorNotes;
  final dynamic customerNotes;
  final dynamic cancellationReason;
  final dynamic returnReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final Vendor? vendor;

  Item copyWith({
    SelectedOptions? selectedOptions,
    dynamic? id,
    dynamic? orderId,
    dynamic? productId,
    dynamic? vendorId,
    dynamic? quantity,
    String? price,
    String? discountPrice,
    String? fulfillmentStatus,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? receivedAt,
    dynamic? trackingNumber,
    dynamic? vendorNotes,
    dynamic? customerNotes,
    dynamic? cancellationReason,
    dynamic? returnReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
    Vendor? vendor,
  }) {
    return Item(
      selectedOptions: selectedOptions ?? this.selectedOptions,
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      vendorId: vendorId ?? this.vendorId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      fulfillmentStatus: fulfillmentStatus ?? this.fulfillmentStatus,
      shippedAt: shippedAt ?? this.shippedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      receivedAt: receivedAt ?? this.receivedAt,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      vendorNotes: vendorNotes ?? this.vendorNotes,
      customerNotes: customerNotes ?? this.customerNotes,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      returnReason: returnReason ?? this.returnReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
      vendor: vendor ?? this.vendor,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      selectedOptions: json["selectedOptions"] == null ? null : SelectedOptions.fromJson(json["selectedOptions"]),
      id: json["id"],
      orderId: json["orderId"],
      productId: json["productId"],
      vendorId: json["vendorId"],
      quantity: json["quantity"],
      price: json["price"],
      discountPrice: json["discountPrice"],
      fulfillmentStatus: json["fulfillmentStatus"],
      shippedAt: DateTime.tryParse(json["shippedAt"] ?? ""),
      deliveredAt: DateTime.tryParse(json["deliveredAt"] ?? ""),
      receivedAt: DateTime.tryParse(json["receivedAt"] ?? ""),
      trackingNumber: json["trackingNumber"],
      vendorNotes: json["vendorNotes"],
      customerNotes: json["customerNotes"],
      cancellationReason: json["cancellationReason"],
      returnReason: json["returnReason"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
      vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "selectedOptions": selectedOptions?.toJson(),
    "id": id,
    "orderId": orderId,
    "productId": productId,
    "vendorId": vendorId,
    "quantity": quantity,
    "price": price,
    "discountPrice": discountPrice,
    "fulfillmentStatus": fulfillmentStatus,
    "shippedAt": shippedAt?.toIso8601String(),
    "deliveredAt": deliveredAt?.toIso8601String(),
    "receivedAt": receivedAt?.toIso8601String(),
    "trackingNumber": trackingNumber,
    "vendorNotes": vendorNotes,
    "customerNotes": customerNotes,
    "cancellationReason": cancellationReason,
    "returnReason": returnReason,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
    "vendor": vendor?.toJson(),
  };

  @override
  String toString(){
    return "$selectedOptions, $id, $orderId, $productId, $vendorId, $quantity, $price, $discountPrice, $fulfillmentStatus, $shippedAt, $deliveredAt, $receivedAt, $trackingNumber, $vendorNotes, $customerNotes, $cancellationReason, $returnReason, $createdAt, $updatedAt, $product, $vendor, ";
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.coverImage,
    required this.reviews,
  });

  final dynamic? id;
  final String? name;
  final String? coverImage;
  final List<Review> reviews;

  Product copyWith({
    dynamic? id,
    String? name,
    String? coverImage,
    List<Review>? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      coverImage: coverImage ?? this.coverImage,
      reviews: reviews ?? this.reviews,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      coverImage: json["coverImage"],
      reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coverImage": coverImage,
    "reviews": reviews.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $coverImage, $reviews, ";
  }
}

class Review {
  Review({
    required this.id,
    required this.rating,
    required this.review,
    required this.userId,
  });

  final dynamic? id;
  final dynamic? rating;
  final String? review;
  final dynamic? userId;

  Review copyWith({
    dynamic? id,
    dynamic? rating,
    String? review,
    dynamic? userId,
  }) {
    return Review(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      userId: userId ?? this.userId,
    );
  }

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      id: json["id"],
      rating: json["rating"],
      review: json["review"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "review": review,
    "userId": userId,
  };

  @override
  String toString(){
    return "$id, $rating, $review, $userId, ";
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

class Vendor {
  Vendor({
    required this.businessName,
    required this.businessLogo,
  });

  final String? businessName;
  final String? businessLogo;

  Vendor copyWith({
    String? businessName,
    String? businessLogo,
  }) {
    return Vendor(
      businessName: businessName ?? this.businessName,
      businessLogo: businessLogo ?? this.businessLogo,
    );
  }

  factory Vendor.fromJson(Map<String, dynamic> json){
    return Vendor(
      businessName: json["businessName"],
      businessLogo: json["businessLogo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "businessLogo": businessLogo,
  };

  @override
  String toString(){
    return "$businessName, $businessLogo, ";
  }
}

class StateFeeDetails {
  StateFeeDetails({
    required this.state,
    required this.fee,
  });

  final String? state;
  final num? fee;

  StateFeeDetails copyWith({
    String? state,
    num? fee,
  }) {
    return StateFeeDetails(
      state: state ?? this.state,
      fee: fee ?? this.fee,
    );
  }

  factory StateFeeDetails.fromJson(Map<String, dynamic> json){
    return StateFeeDetails(
      state: json["state"],
      fee: json["fee"],
    );
  }

  Map<String, dynamic> toJson() => {
    "state": state,
    "fee": fee,
  };

  @override
  String toString(){
    return "$state, $fee, ";
  }
}

class PickupStationDetails {
  PickupStationDetails({
    required this.name,
    required this.state,
    required this.address,
    required this.fee,
    required this.contactPhone,
  });

  final String? name;
  final String? state;
  final String? address;
  final dynamic? fee;
  final String? contactPhone;

  PickupStationDetails copyWith({
    String? name,
    String? state,
    String? address,
    dynamic? fee,
    String? contactPhone,
  }) {
    return PickupStationDetails(
      name: name ?? this.name,
      state: state ?? this.state,
      address: address ?? this.address,
      fee: fee ?? this.fee,
      contactPhone: contactPhone ?? this.contactPhone,
    );
  }

  factory PickupStationDetails.fromJson(Map<String, dynamic> json){
    return PickupStationDetails(
      name: json["name"],
      state: json["state"],
      address: json["address"],
      fee: json["fee"],
      contactPhone: json["contactPhone"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "state": state,
    "address": address,
    "fee": fee,
    "contactPhone": contactPhone,
  };

  @override
  String toString(){
    return "$name, $state, $address, $fee, $contactPhone, ";
  }
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  final String? firstName;
  final String? lastName;
  final String? photo;

  User copyWith({
    String? firstName,
    String? lastName,
    String? photo,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photo: photo ?? this.photo,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "photo": photo,
  };

  @override
  String toString(){
    return "$firstName, $lastName, $photo, ";
  }
}

class WalletDetails {
  WalletDetails({
    required this.name,
    required this.address,
    required this.barcode,
  });

  final String? name;
  final String? address;
  final String? barcode;

  WalletDetails copyWith({
    String? name,
    String? address,
    String? barcode,
  }) {
    return WalletDetails(
      name: name ?? this.name,
      address: address ?? this.address,
      barcode: barcode ?? this.barcode,
    );
  }

  factory WalletDetails.fromJson(Map<String, dynamic> json){
    return WalletDetails(
      name: json["name"],
      address: json["address"],
      barcode: json["barcode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "barcode": barcode,
  };

  @override
  String toString(){
    return "$name, $address, $barcode, ";
  }
}
