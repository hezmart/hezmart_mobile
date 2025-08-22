class UpdateCartPayload {
  UpdateCartPayload({
    required this.quantity,
  });

  final dynamic? quantity;

  UpdateCartPayload copyWith({
    dynamic? quantity,
  }) {
    return UpdateCartPayload(
      quantity: quantity ?? this.quantity,
    );
  }

  factory UpdateCartPayload.fromJson(Map<String, dynamic> json){
    return UpdateCartPayload(
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
  };

  @override
  String toString(){
    return "$quantity, ";
  }
}
