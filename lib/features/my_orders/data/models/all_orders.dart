class GetAllOrdersResponse {
  GetAllOrdersResponse({
    required this.status,
    required this.pagination,
    required this.data,
  });

  final String? status;
  final Pagination? pagination;
  final Data? data;

  GetAllOrdersResponse copyWith({
    String? status,
    Pagination? pagination,
    Data? data,
  }) {
    return GetAllOrdersResponse(
      status: status ?? this.status,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  factory GetAllOrdersResponse.fromJson(Map<String, dynamic> json){
    return GetAllOrdersResponse(
      status: json["status"],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "pagination": pagination?.toJson(),
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $pagination, $data, ";
  }
}

class Data {
  Data({
    required this.orders,
    required this.meta,
  });

  final List<Order> orders;
  final dynamic meta;

  Data copyWith({
    List<Order>? orders,
    dynamic? meta,
  }) {
    return Data(
      orders: orders ?? this.orders,
      meta: meta ?? this.meta,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      meta: json["meta"],
    );
  }

  Map<String, dynamic> toJson() => {
    "orders": orders.map((x) => x?.toJson()).toList(),
    "meta": meta,
  };

  @override
  String toString(){
    return "$orders, $meta, ";
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
  final dynamic? walletDetails;
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
  final dynamic? couponId;
  final String? couponCode;
  final dynamic trackingNumber;
  final dynamic customerNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item> items;
  final User? user;

  Order copyWith({
    StateFeeDetails? stateFeeDetails,
    PickupStationDetails? pickupStationDetails,
    dynamic? walletDetails,
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
    num? couponId,
    String? couponCode,
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
      walletDetails: json["walletDetails"],
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
    "walletDetails": walletDetails,
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
    required this.email,
    required this.primaryAddress,
    required this.secondaryPhone,
    required this.city,
    required this.country,
  });

  final String? firstName;
  final String? lastName;
  final String? primaryPhone;
  final String? state;
  final String? email;
  final String? primaryAddress;
  final dynamic secondaryPhone;
  final String? city;
  final String? country;

  DeliveryAddress copyWith({
    String? firstName,
    String? lastName,
    String? primaryPhone,
    String? state,
    String? email,
    String? primaryAddress,
    dynamic? secondaryPhone,
    String? city,
    String? country,
  }) {
    return DeliveryAddress(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      state: state ?? this.state,
      email: email ?? this.email,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      secondaryPhone: secondaryPhone ?? this.secondaryPhone,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  factory DeliveryAddress.fromJson(Map<String, dynamic> json){
    return DeliveryAddress(
      firstName: json["firstName"],
      lastName: json["lastName"],
      primaryPhone: json["primaryPhone"],
      state: json["state"],
      email: json["email"],
      primaryAddress: json["primaryAddress"],
      secondaryPhone: json["secondaryPhone"],
      city: json["city"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "primaryPhone": primaryPhone,
    "state": state,
    "email": email,
    "primaryAddress": primaryAddress,
    "secondaryPhone": secondaryPhone,
    "city": city,
    "country": country,
  };

  @override
  String toString(){
    return "$firstName, $lastName, $primaryPhone, $state, $email, $primaryAddress, $secondaryPhone, $city, $country, ";
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
  });

  final dynamic? id;
  final String? name;
  final String? coverImage;

  Product copyWith({
    dynamic? id,
    String? name,
    String? coverImage,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      coverImage: json["coverImage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coverImage": coverImage,
  };

  @override
  String toString(){
    return "$id, $name, $coverImage, ";
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

class Vendor {
  Vendor({
    required this.id,
    required this.businessName,
    required this.businessLogo,
  });

  final dynamic? id;
  final String? businessName;
  final String? businessLogo;

  Vendor copyWith({
    dynamic? id,
    String? businessName,
    String? businessLogo,
  }) {
    return Vendor(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      businessLogo: businessLogo ?? this.businessLogo,
    );
  }

  factory Vendor.fromJson(Map<String, dynamic> json){
    return Vendor(
      id: json["id"],
      businessName: json["businessName"],
      businessLogo: json["businessLogo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "businessName": businessName,
    "businessLogo": businessLogo,
  };

  @override
  String toString(){
    return "$id, $businessName, $businessLogo, ";
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

class StateFeeDetails {
  StateFeeDetails({
    required this.state,
    required this.fee,
  });

  final String? state;
  final dynamic? fee;

  StateFeeDetails copyWith({
    String? state,
    dynamic? fee,
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

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  final dynamic? id;
  final String? firstName;
  final String? lastName;
  final String? photo;

  User copyWith({
    dynamic? id,
    String? firstName,
    String? lastName,
    String? photo,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photo: photo ?? this.photo,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "photo": photo,
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $photo, ";
  }
}

class WalletDetailsClass {
  WalletDetailsClass({
    required this.name,
    required this.address,
    required this.barcode,
  });

  final String? name;
  final String? address;
  final String? barcode;

  WalletDetailsClass copyWith({
    String? name,
    String? address,
    String? barcode,
  }) {
    return WalletDetailsClass(
      name: name ?? this.name,
      address: address ?? this.address,
      barcode: barcode ?? this.barcode,
    );
  }

  factory WalletDetailsClass.fromJson(Map<String, dynamic> json){
    return WalletDetailsClass(
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

class Pagination {
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.nextPage,
    required this.prevPage,
  });

  final dynamic? totalItems;
  final dynamic? currentPage;
  final dynamic? totalPages;
  final dynamic? perPage;
  final dynamic nextPage;
  final dynamic prevPage;

  Pagination copyWith({
    dynamic? totalItems,
    dynamic? currentPage,
    dynamic? totalPages,
    dynamic? perPage,
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
