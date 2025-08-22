class AllCategoryResponse {
  AllCategoryResponse({
    required this.status,
    required this.result,
    required this.data,
  });

  final String? status;
  final dynamic? result;
  final Data? data;

  AllCategoryResponse copyWith({
    String? status,
    dynamic? result,
    Data? data,
  }) {
    return AllCategoryResponse(
      status: status ?? this.status,
      result: result ?? this.result,
      data: data ?? this.data,
    );
  }

  factory AllCategoryResponse.fromJson(Map<String, dynamic> json){
    return AllCategoryResponse(
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
    required this.categories,
  });

  final List<Category> categories;

  Data copyWith({
    List<Category>? categories,
  }) {
    return Data(
      categories: categories ?? this.categories,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "categories": categories.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$categories, ";
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategories,
  });

  final dynamic? id;
  final String? name;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Subcategory> subcategories;

  Category copyWith({
    dynamic? id,
    String? name,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Subcategory>? subcategories,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "subcategories": subcategories.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $icon, $createdAt, $updatedAt, $subcategories, ";
  }
}

class Subcategory {
  Subcategory({
    required this.name,
    required this.id,
  });

  final String? name;
  final dynamic? id;

  Subcategory copyWith({
    String? name,
    dynamic? id,
  }) {
    return Subcategory(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  factory Subcategory.fromJson(Map<String, dynamic> json){
    return Subcategory(
      name: json["name"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };

  @override
  String toString(){
    return "$name, $id, ";
  }
}
