
class AccountModel {
  int? customerId;
  int? accountId;
  String? customerName;
  String? customerPhone;
  dynamic account;
  List<dynamic>? customerAddresses;
  List<dynamic>? orders;

  AccountModel({this.customerId, this.accountId, this.customerName, this.customerPhone, this.account, this.customerAddresses, this.orders});

  AccountModel.fromJson(Map<String, dynamic> json) {
    if(json["customerId"] is int) {
      customerId = json["customerId"];
    }
    if(json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if(json["customerName"] is String) {
      customerName = json["customerName"];
    }
    if(json["customerPhone"] is String) {
      customerPhone = json["customerPhone"];
    }
    account = json["account"];
    if(json["customerAddresses"] is List) {
      customerAddresses = json["customerAddresses"] ?? [];
    }
    if(json["orders"] is List) {
      orders = json["orders"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customerId"] = customerId;
    data["accountId"] = accountId;
    data["customerName"] = customerName;
    data["customerPhone"] = customerPhone;
    data["account"] = account;
    if(customerAddresses != null) {
      data["customerAddresses"] = customerAddresses;
    }
    if(orders != null) {
      data["orders"] = orders;
    }
    return data;
  }
}