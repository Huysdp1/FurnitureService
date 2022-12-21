
class OrderModel {
  int? orderId;
  int? customerId;
  int? workingStatusId;
  String? address;
  String? totalPrice;
  String? createAt;
  String? description;
  bool? status;
  List<dynamic>? assigns;
  List<dynamic>? orderImages;
  List<dynamic>? orderServices;
  String? implementationDate;
  String? implementationTime;

  OrderModel({this.orderId, this.customerId, this.workingStatusId, this.address, this.totalPrice, this.createAt, this.description, this.status, this.assigns, this.orderImages, this.orderServices, this.implementationDate, this.implementationTime});

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
    if(json["createAt"] is String) {
      createAt = json["createAt"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["assigns"] is List) {
      assigns = json["assigns"] ?? [];
    }
    if(json["orderImages"] is List) {
      orderImages = json["orderImages"] ?? [];
    }
    if(json["orderServices"] is List) {
      orderServices = json["orderServices"] ?? [];
    }
    if(json["implementationDate"] is String) {
      implementationDate = json["implementationDate"];
    }
    if(json["implementationTime"] is String) {
      implementationTime = json["implementationTime"];
    }
  }

  static List<OrderModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["customerId"] = customerId;
    _data["workingStatusId"] = workingStatusId;
    _data["address"] = address;
    _data["totalPrice"] = totalPrice;
    _data["createAt"] = createAt;
    _data["description"] = description;
    _data["status"] = status;
    if(assigns != null) {
      _data["assigns"] = assigns;
    }
    if(orderImages != null) {
      _data["orderImages"] = orderImages;
    }
    if(orderServices != null) {
      _data["orderServices"] = orderServices;
    }
    _data["implementationDate"] = implementationDate;
    _data["implementationTime"] = implementationTime;
    return _data;
  }

  OrderModel copyWith({
    int? orderId,
    int? customerId,
    int? workingStatusId,
    String? address,
    String? totalPrice,
    String? createAt,
    String? description,
    bool? status,
    List<dynamic>? assigns,
    List<dynamic>? orderImages,
    List<dynamic>? orderServices,
    String? implementationDate,
    String? implementationTime,
  }) => OrderModel(
    orderId: orderId ?? this.orderId,
    customerId: customerId ?? this.customerId,
    workingStatusId: workingStatusId ?? this.workingStatusId,
    address: address ?? this.address,
    totalPrice: totalPrice ?? this.totalPrice,
    createAt: createAt ?? this.createAt,
    description: description ?? this.description,
    status: status ?? this.status,
    assigns: assigns ?? this.assigns,
    orderImages: orderImages ?? this.orderImages,
    orderServices: orderServices ?? this.orderServices,
    implementationDate: implementationDate ?? this.implementationDate,
    implementationTime: implementationTime ?? this.implementationTime,
  );
}