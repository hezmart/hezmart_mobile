class AllSubCategoryResspomse {
  AllSubCategoryResspomse({
    required this.status,
    required this.result,
    required this.data,
  });

  final String? status;
  final dynamic? result;
  final Data? data;

  AllSubCategoryResspomse copyWith({
    String? status,
    dynamic? result,
    Data? data,
  }) {
    return AllSubCategoryResspomse(
      status: status ?? this.status,
      result: result ?? this.result,
      data: data ?? this.data,
    );
  }

  factory AllSubCategoryResspomse.fromJson(Map<String, dynamic> json){
    return AllSubCategoryResspomse(
      status: json["status"],
      result: json["result"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $result, $data, ";
  }
}

class Data {
  Data({
    required this.subcategories,
  });

  final List<Subcategory> subcategories;

  Data copyWith({
    List<Subcategory>? subcategories,
  }) {
    return Data(
      subcategories: subcategories ?? this.subcategories,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "subcategories": subcategories.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$subcategories, ";
  }
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.subcategoryCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
  });

  final dynamic? id;
  final String? name;
  final dynamic description;
  final dynamic? subcategoryCategoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? categoryId;

  Subcategory copyWith({
    dynamic? id,
    String? name,
    dynamic? description,
    dynamic? subcategoryCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
  }) {
    return Subcategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subcategoryCategoryId: subcategoryCategoryId ?? this.subcategoryCategoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  factory Subcategory.fromJson(Map<String, dynamic> json){
    return Subcategory(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      subcategoryCategoryId: json["categoryId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      categoryId: json["CategoryId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "categoryId": subcategoryCategoryId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "CategoryId": categoryId,
  };

  @override
  String toString(){
    return "$id, $name, $description, $subcategoryCategoryId, $createdAt, $updatedAt, $categoryId, ";
  }
}
