
class OrderDetail {
  String? statusName;
  String? address;
  String? totalPrice;
  String? createAt;
  dynamic updateAt;
  dynamic description;
  List<dynamic>? listEmployeeDto;
  List<ListOrderServiceDto>? listOrderServiceDto;

  OrderDetail({this.statusName, this.address, this.totalPrice, this.createAt, this.updateAt, this.description, this.listEmployeeDto, this.listOrderServiceDto});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    if(json["statusName"] is String) {
      statusName = json["statusName"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["totalPrice"] is String) {
      totalPrice = json["totalPrice"];
    }
    if(json["createAt"] is String) {
      createAt = json["createAt"];
    }
    updateAt = json["updateAt"];
    description = json["description"];
    if(json["listEmployeeDto"] is List) {
      listEmployeeDto = json["listEmployeeDto"] ?? [];
    }
    if(json["listOrderServiceDto"] is List) {
      listOrderServiceDto = json["listOrderServiceDto"] == null ? null : (json["listOrderServiceDto"] as List).map((e) => ListOrderServiceDto.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["statusName"] = statusName;
    data["address"] = address;
    data["totalPrice"] = totalPrice;
    data["createAt"] = createAt;
    data["updateAt"] = updateAt;
    data["description"] = description;
    if(listEmployeeDto != null) {
      data["listEmployeeDto"] = listEmployeeDto;
    }
    if(listOrderServiceDto != null) {
      data["listOrderServiceDto"] = listOrderServiceDto?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListOrderServiceDto {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  String? serviceName;
  String? price;
  dynamic categoryName;
  dynamic quantity;
  dynamic estimateTimeFinish;

  ListOrderServiceDto({this.orderServiceId, this.orderId, this.serviceId, this.serviceName, this.price, this.categoryName, this.quantity, this.estimateTimeFinish});

  ListOrderServiceDto.fromJson(Map<String, dynamic> json) {
    if(json["orderServiceId"] is int) {
      orderServiceId = json["orderServiceId"];
    }
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["serviceName"] is String) {
      serviceName = json["serviceName"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    categoryName = json["categoryName"];
    quantity = json["quantity"];
    estimateTimeFinish = json["estimateTimeFinish"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderServiceId"] = orderServiceId;
    data["orderId"] = orderId;
    data["serviceId"] = serviceId;
    data["serviceName"] = serviceName;
    data["price"] = price;
    data["categoryName"] = categoryName;
    data["quantity"] = quantity;
    data["estimateTimeFinish"] = estimateTimeFinish;
    return data;
  }
}