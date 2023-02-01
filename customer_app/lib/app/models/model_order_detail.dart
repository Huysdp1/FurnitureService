
class OrderDetail {
  String? statusName;
  String? address;
  String? totalPrice;
  String? createAt;
  dynamic updateAt;
  String? description;
  List<ListEmployeeDto>? listEmployeeDto;
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
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["listEmployeeDto"] is List) {
      listEmployeeDto = json["listEmployeeDto"] == null ? null : (json["listEmployeeDto"] as List).map((e) => ListEmployeeDto.fromJson(e)).toList();
    }
    if(json["listOrderServiceDto"] is List) {
      listOrderServiceDto = json["listOrderServiceDto"] == null ? null : (json["listOrderServiceDto"] as List).map((e) => ListOrderServiceDto.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["statusName"] = statusName;
    _data["address"] = address;
    _data["totalPrice"] = totalPrice;
    _data["createAt"] = createAt;
    _data["updateAt"] = updateAt;
    _data["description"] = description;
    if(listEmployeeDto != null) {
      _data["listEmployeeDto"] = listEmployeeDto?.map((e) => e.toJson()).toList();
    }
    if(listOrderServiceDto != null) {
      _data["listOrderServiceDto"] = listOrderServiceDto?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListOrderServiceDto {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  String? serviceName;
  String? price;
  String? categoryName;
  int? quantity;
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
    if(json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
    estimateTimeFinish = json["estimateTimeFinish"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderServiceId"] = orderServiceId;
    _data["orderId"] = orderId;
    _data["serviceId"] = serviceId;
    _data["serviceName"] = serviceName;
    _data["price"] = price;
    _data["categoryName"] = categoryName;
    _data["quantity"] = quantity;
    _data["estimateTimeFinish"] = estimateTimeFinish;
    return _data;
  }
}

class ListEmployeeDto {
  dynamic imageUrl;
  int? accountId;
  String? employeeName;
  dynamic email;
  String? employeePhoneNumber;
  bool? status;

  ListEmployeeDto({this.imageUrl, this.accountId, this.employeeName, this.email, this.employeePhoneNumber, this.status});

  ListEmployeeDto.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
    if(json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if(json["employeeName"] is String) {
      employeeName = json["employeeName"];
    }
    email = json["email"];
    if(json["employeePhoneNumber"] is String) {
      employeePhoneNumber = json["employeePhoneNumber"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imageUrl"] = imageUrl;
    _data["accountId"] = accountId;
    _data["employeeName"] = employeeName;
    _data["email"] = email;
    _data["employeePhoneNumber"] = employeePhoneNumber;
    _data["status"] = status;
    return _data;
  }
}