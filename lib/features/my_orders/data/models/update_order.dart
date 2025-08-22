class UpdateOrderpayload {
  UpdateOrderpayload({
    required this.status,
  });

  final String? status;

  UpdateOrderpayload copyWith({
    String? status,
  }) {
    return UpdateOrderpayload(
      status: status ?? this.status,
    );
  }

  factory UpdateOrderpayload.fromJson(Map<String, dynamic> json){
    return UpdateOrderpayload(
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
  };

  @override
  String toString(){
    return "$status, ";
  }
}
