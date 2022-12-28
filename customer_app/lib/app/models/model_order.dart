
class OrderModel {
  int? orderId;
  int? customerId;
  int? workingStatusId;
  String? address;
  String? totalPrice;
  String? implementationDate;
  String? implementationTime;
  String? createAt;
  dynamic updateAt;
  dynamic description;
  bool? status;
  dynamic customer;
  dynamic workingStatus;
  List<dynamic>? assigns;
  List<dynamic>? orderImages;
  List<OrderServices>? orderServices;

  OrderModel({this.orderId, this.customerId, this.workingStatusId, this.address, this.totalPrice, this.implementationDate, this.implementationTime, this.createAt, this.updateAt, this.description, this.status, this.customer, this.workingStatus, this.assigns, this.orderImages, this.orderServices});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if(json["orderId"] is num) {
      orderId = (json["orderId"] as num).toInt();
    }
    if(json["customerId"] is num) {
      customerId = (json["customerId"] as num).toInt();
    }
    if(json["workingStatusId"] is num) {
      workingStatusId = (json["workingStatusId"] as num).toInt();
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["totalPrice"] is String) {
      totalPrice = json["totalPrice"];
    }
    if(json["implementationDate"] is String) {
      implementationDate = json["implementationDate"];
    }
    if(json["implementationTime"] is String) {
      implementationTime = json["implementationTime"];
    }
    if(json["createAt"] is String) {
      createAt = json["createAt"];
    }
    updateAt = json["updateAt"];
    description = json["description"];
    if(json["status"] is bool) {
      status = json["status"];
    }
    customer = json["customer"];
    workingStatus = json["workingStatus"];
    if(json["assigns"] is List) {
      assigns = json["assigns"] ?? [];
    }
    if(json["orderImages"] is List) {
      orderImages = json["orderImages"] ?? [];
    }
    if(json["orderServices"] is List) {
      orderServices = json["orderServices"] == null ? null : (json["orderServices"] as List).map((e) => OrderServices.fromJson(e)).toList();
    }
  }

  static List<OrderModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderId"] = orderId;
    data["customerId"] = customerId;
    data["workingStatusId"] = workingStatusId;
    data["address"] = address;
    data["totalPrice"] = totalPrice;
    data["implementationDate"] = implementationDate;
    data["implementationTime"] = implementationTime;
    data["createAt"] = createAt;
    data["updateAt"] = updateAt;
    data["description"] = description;
    data["status"] = status;
    data["customer"] = customer;
    data["workingStatus"] = workingStatus;
    if(assigns != null) {
      data["assigns"] = assigns;
    }
    if(orderImages != null) {
      data["orderImages"] = orderImages;
    }
    if(orderServices != null) {
      data["orderServices"] = orderServices?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  OrderModel copyWith({
    int? orderId,
    int? customerId,
    int? workingStatusId,
    String? address,
    String? totalPrice,
    String? implementationDate,
    String? implementationTime,
    String? createAt,
    dynamic updateAt,
    dynamic description,
    bool? status,
    dynamic customer,
    dynamic workingStatus,
    List<dynamic>? assigns,
    List<dynamic>? orderImages,
    List<OrderServices>? orderServices,
  }) => OrderModel(
    orderId: orderId ?? this.orderId,
    customerId: customerId ?? this.customerId,
    workingStatusId: workingStatusId ?? this.workingStatusId,
    address: address ?? this.address,
    totalPrice: totalPrice ?? this.totalPrice,
    implementationDate: implementationDate ?? this.implementationDate,
    implementationTime: implementationTime ?? this.implementationTime,
    createAt: createAt ?? this.createAt,
    updateAt: updateAt ?? this.updateAt,
    description: description ?? this.description,
    status: status ?? this.status,
    customer: customer ?? this.customer,
    workingStatus: workingStatus ?? this.workingStatus,
    assigns: assigns ?? this.assigns,
    orderImages: orderImages ?? this.orderImages,
    orderServices: orderServices ?? this.orderServices,
  );
}

class OrderServices {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  int? quantity;
  dynamic estimateTimeFinish;
  dynamic service;

  OrderServices({this.orderServiceId, this.orderId, this.serviceId, this.quantity, this.estimateTimeFinish, this.service});

  OrderServices.fromJson(Map<String, dynamic> json) {
    if(json["orderServiceId"] is num) {
      orderServiceId = (json["orderServiceId"] as num).toInt();
    }
    if(json["orderId"] is num) {
      orderId = (json["orderId"] as num).toInt();
    }
    if(json["serviceId"] is num) {
      serviceId = (json["serviceId"] as num).toInt();
    }
    if(json["quantity"] is num) {
      quantity = (json["quantity"] as num).toInt();
    }
    estimateTimeFinish = json["estimateTimeFinish"];
    service = json["service"];
  }

  static List<OrderServices> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderServices.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderServiceId"] = orderServiceId;
    data["orderId"] = orderId;
    data["serviceId"] = serviceId;
    data["quantity"] = quantity;
    data["estimateTimeFinish"] = estimateTimeFinish;
    data["service"] = service;
    return data;
  }

  OrderServices copyWith({
    int? orderServiceId,
    int? orderId,
    int? serviceId,
    int? quantity,
    dynamic estimateTimeFinish,
    dynamic service,
  }) => OrderServices(
    orderServiceId: orderServiceId ?? this.orderServiceId,
    orderId: orderId ?? this.orderId,
    serviceId: serviceId ?? this.serviceId,
    quantity: quantity ?? this.quantity,
    estimateTimeFinish: estimateTimeFinish ?? this.estimateTimeFinish,
    service: service ?? this.service,
  );
}