class ReferalPaayload {
  ReferalPaayload({required this.name, required this.motive});

  final String? name;
  final String? motive;

  ReferalPaayload copyWith({String? name, String? motive}) {
    return ReferalPaayload(
      name: name ?? this.name,
      motive: motive ?? this.motive,
    );
  }

  factory ReferalPaayload.fromJson(Map<String, dynamic> json) {
    return ReferalPaayload(name: json["name"], motive: json["motive"]);
  }

  Map<String, dynamic> toJson() => {"name": name, "motive": motive};

  @override
  String toString() {
    return "$name, $motive, ";
  }
}
