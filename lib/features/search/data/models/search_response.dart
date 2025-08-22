class SearchResponse {
  SearchResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  final String? status;
  final num? results;
  final Data? data;

  SearchResponse copyWith({
    String? status,
    num? results,
    Data? data,
  }) {
    return SearchResponse(
      status: status ?? this.status,
      results: results ?? this.results,
      data: data ?? this.data,
    );
  }

  factory SearchResponse.fromJson(Map<String, dynamic> json){
    return SearchResponse(
      status: json["status"],
      results: json["results"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $results, $data, ";
  }
}

class Data {
  Data({
    required this.results,
  });

  final List<Result> results;

  Data copyWith({
    List<Result>? results,
  }) {
    return Data(
      results: results ?? this.results,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "results": results.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$results, ";
  }
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.coverImage,
    required this.price,
    required this.discountPrice,
    required this.category,
    required this.subCategory,
    required this.type,
    required this.icon,
  });

  final dynamic? id;
  final String? name;
  final String? slug;
  final String? coverImage;
  final String? price;
  final String? discountPrice;
  final Category? category;
  final Category? subCategory;
  final String? type;
  final String? icon;

  Result copyWith({
    dynamic? id,
    String? name,
    String? slug,
    String? coverImage,
    String? price,
    String? discountPrice,
    Category? category,
    Category? subCategory,
    String? type,
    String? icon,
  }) {
    return Result(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      coverImage: coverImage ?? this.coverImage,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      type: type ?? this.type,
      icon: icon ?? this.icon,
    );
  }

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      coverImage: json["coverImage"],
      price: json["price"],
      discountPrice: json["discountPrice"],
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      subCategory: json["subCategory"] == null ? null : Category.fromJson(json["subCategory"]),
      type: json["type"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "coverImage": coverImage,
    "price": price,
    "discountPrice": discountPrice,
    "category": category?.toJson(),
    "subCategory": subCategory?.toJson(),
    "type": type,
    "icon": icon,
  };

  @override
  String toString(){
    return "$id, $name, $slug, $coverImage, $price, $discountPrice, $category, $subCategory, $type, $icon, ";
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final dynamic? id;
  final String? name;

  Category copyWith({
    dynamic? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  String toString(){
    return "$id, $name, ";
  }
}
