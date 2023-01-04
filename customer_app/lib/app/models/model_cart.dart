class ModelCart{
  String? image;
  String? name;
  String? productName;
  String? rating;
  double? price;
  int? quantity;
  double totalPrice(){

    return price! * quantity!;
  }

  ModelCart(this.image, this.name, this.productName, this.rating, this.price,
      this.quantity);
}


class CartModel {
  int? customerId;
  String? address;
  String? createAt;
  String? totalPrice;
  String? implementationDate;
  String? implementationTime;
  List<ListService>? listService;

  CartModel({this.customerId, this.address, this.createAt, this.totalPrice, this.implementationDate, this.implementationTime, this.listService});

  CartModel.fromJson(Map<String, dynamic> json) {
    if(json["customerId"] is int) {
      customerId = json["customerId"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["createAt"] is String) {
      createAt = json["createAt"];
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
    if(json["listService"] is List) {
      listService = json["listService"] == null ? null : (json["listService"] as List).map((e) => ListService.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customerId"] = customerId;
    data["address"] = address;
    data["createAt"] = createAt;
    data["totalPrice"] = totalPrice;
    data["implementationDate"] = implementationDate;
    data["implementationTime"] = implementationTime;
    if(listService != null) {
      data["listService"] = listService?.map((e) => e.toJson()).toList();
    }
    return data;
  }
  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["address"] = address.toString();
    data["updateAt"] = DateTime.parse(DateTime.now().toString()).toString();
    data["totalPrice"] = totalPrice;
    data["implementationDate"] = implementationDate;
    data["implementationTime"] = implementationTime;
    if(listService != null) {
      data["listService"] = listService?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ListService {
  int? serviceId;
  int? quantity;
  ListService({this.serviceId,this.quantity});

  ListService.fromJson(Map<String, dynamic> json) {
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceId"] = serviceId;
    data["quantity"] = quantity;
    return data;
  }
}