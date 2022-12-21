class ModelCategory{
  String? image;
  String? name;

  ModelCategory(this.image, this.name);
}


class CategoryModel {
  int? categoryId;
  String? categoryName;
  bool? status;
  List<dynamic>? services;

  CategoryModel({this.categoryId, this.categoryName, this.status, this.services});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if(json["categoryId"] is num) {
      categoryId = (json["categoryId"] as num).toInt();
    }
    if(json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["services"] is List) {
      services = json["services"] ?? [];
    }
  }

  static List<CategoryModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CategoryModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["categoryId"] = categoryId;
    _data["categoryName"] = categoryName;
    _data["status"] = status;
    if(services != null) {
      _data["services"] = services;
    }
    return _data;
  }

  CategoryModel copyWith({
    int? categoryId,
    String? categoryName,
    bool? status,
    List<dynamic>? services,
  }) => CategoryModel(
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    status: status ?? this.status,
    services: services ?? this.services,
  );
}