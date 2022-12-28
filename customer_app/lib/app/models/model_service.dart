
class ServiceModel {
  int? serviceId;
  int? categoryId;
  String? categoryName;
  String? serviceName;
  String? serviceDescription;
  String? type;
  String? price;
  int? quantity;

  ServiceModel({this.serviceId, this.categoryId, this.categoryName, this.serviceName, this.serviceDescription, this.type, this.price, this.quantity});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["categoryId"] is int) {
      categoryId = json["categoryId"];
    }
    if(json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
    if(json["serviceName"] is String) {
      serviceName = json["serviceName"];
    }
    if(json["serviceDescription"] is String) {
      serviceDescription = json["serviceDescription"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"] ?? 0;
    }else{
      quantity = 0;
    }
  }

  static List<ServiceModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ServiceModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceId"] = serviceId;
    data["categoryId"] = categoryId;
    data["categoryName"] = categoryName;
    data["serviceName"] = serviceName;
    data["serviceDescription"] = serviceDescription;
    data["type"] = type;
    data["price"] = price;
    data["quantity"] = quantity;
    return data;
  }

  ServiceModel copyWith({
    int? serviceId,
    int? categoryId,
    String? categoryName,
    String? serviceName,
    String? serviceDescription,
    String? type,
    String? price,
    int? quantity,
  }) => ServiceModel(
    serviceId: serviceId ?? this.serviceId,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    serviceName: serviceName ?? this.serviceName,
    serviceDescription: serviceDescription ?? this.serviceDescription,
    type: type ?? this.type,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity
  );
}