class ConfirmOrderDoorDeliverypayload {
  ConfirmOrderDoorDeliverypayload({
    required this.deliveryAddress,
    required this.deliveryOption,
    required this.paymentMethod,
    required this.selectedStateId,
  });

  final DeliveryAddress? deliveryAddress;
  final String? deliveryOption;
  final String? paymentMethod;
  final dynamic? selectedStateId;

  ConfirmOrderDoorDeliverypayload copyWith({
    DeliveryAddress? deliveryAddress,
    String? deliveryOption,
    String? paymentMethod,
    dynamic? selectedStateId,
  }) {
    return ConfirmOrderDoorDeliverypayload(
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectedStateId: selectedStateId ?? this.selectedStateId,
    );
  }

  factory ConfirmOrderDoorDeliverypayload.fromJson(Map<String, dynamic> json){
    return ConfirmOrderDoorDeliverypayload(
      deliveryAddress: json["deliveryAddress"] == null ? null : DeliveryAddress.fromJson(json["deliveryAddress"]),
      deliveryOption: json["deliveryOption"],
      paymentMethod: json["paymentMethod"],
      selectedStateId: json["selectedStateId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "deliveryAddress": deliveryAddress?.toJson(),
    "deliveryOption": deliveryOption,
    "paymentMethod": paymentMethod,
    "selectedStateId": selectedStateId,
  };

  @override
  String toString(){
    return "$deliveryAddress, $deliveryOption, $paymentMethod, $selectedStateId, ";
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
