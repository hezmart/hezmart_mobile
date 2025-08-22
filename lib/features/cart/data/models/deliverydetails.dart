class DeliveryInfo {
  final String method;
  final String? stateName;
  final String? fee;
  final String? pickupName;
  final String? pickupAddress;
  final String? pickupPhone;
  final String? pickupFee;

  DeliveryInfo({
    required this.method,
    this.stateName,
    this.fee,
    this.pickupName,
    this.pickupAddress,
    this.pickupPhone,
    this.pickupFee,
  });
}
