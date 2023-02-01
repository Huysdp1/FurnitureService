
import 'package:customer_app/app/models/model_address.dart';

class OrderModel {
  int? orderId;
  int? customerId;
  int? workingStatusId;
  String? address;
  String? totalPrice;
  String? implementationDate;
  String? implementationTime;
  String? createAt;
  //List<ListOrderService>? listOrderService;

  OrderModel({this.orderId, this.customerId, this.workingStatusId, this.address, this.totalPrice, this.implementationDate, this.implementationTime, this.createAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["customerId"] is int) {
      customerId = json["customerId"];
    }
    if(json["workingStatusId"] is int) {
      workingStatusId = json["workingStatusId"];
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
    // if(json["listOrderService"] is List) {
    //   listOrderService = json["listOrderService"] == null ? null : (json["listOrderService"] as List).map((e) => ListOrderService.fromJson(e)).toList();
    // }
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
    // if(listOrderService != null) {
    //   data["listOrderService"] = listOrderService?.map((e) => e.toJson()).toList();
    // }
    return data;
  }
}

// class ListOrderService {
//   int? orderServiceId;
//   int? quantity;
//   int? serviceId;
//   String? serviceName;
//   String? price;
//
//   ListOrderService({this.orderServiceId, this.quantity, this.serviceId, this.serviceName, this.price});
//
//   ListOrderService.fromJson(Map<String, dynamic> json) {
//     if(json["orderServiceId"] is int) {
//       orderServiceId = json["orderServiceId"];
//     }
//     if(json["quantity"] is int) {
//       quantity = json["quantity"];
//     }
//     if(json["serviceId"] is int) {
//       serviceId = json["serviceId"];
//     }
//     if(json["serviceName"] is String) {
//       serviceName = json["serviceName"];
//     }
//     if(json["price"] is String) {
//       price = json["price"];
//     }
//   }
//
//   static List<ListOrderService> fromList(List<Map<String, dynamic>> list) {
//     return list.map((map) => ListOrderService.fromJson(map)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["orderServiceId"] = orderServiceId;
//     data["quantity"] = quantity;
//     data["serviceId"] = serviceId;
//     data["serviceName"] = serviceName;
//     data["price"] = price;
//     return data;
//   }
// }
