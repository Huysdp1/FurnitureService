class ModelAddress{
  String? name;
  String? address;
  String? phone;

  ModelAddress(this.name, this.address, this.phone);
}


class AddressModel {
  int? addressId;
  int? customerId;
  String? homeNumber;
  String? street;
  String? ward;
  String? district;
  String? city;
  bool? isDefault;
  String? customer;

  AddressModel({this.addressId, this.customerId, this.homeNumber, this.street, this.ward, this.district, this.city, this.isDefault, this.customer});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if(json["addressId"] is int) {
      addressId = json["addressId"];
    }
    if(json["customerId"] is int) {
      customerId = json["customerId"];
    }
    if(json["homeNumber"] is String) {
      homeNumber = json["homeNumber"];
    }
    if(json["street"] is String) {
      street = json["street"];
    }
    if(json["ward"] is String) {
      ward = json["ward"];
    }
    if(json["district"] is String) {
      district = json["district"];
    }
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["isDefault"] is bool) {
      isDefault = json["isDefault"];
    }
    if(json["customer"] is String) {
      customer = json["customer"];
    }
  }

  static List<AddressModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AddressModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["customerId"] = customerId;
    _data["homeNumber"] = homeNumber;
    _data["street"] = street;
    _data["ward"] = ward;
    _data["district"] = district;
    _data["city"] = city;
    _data["customer"] = customer;
    return _data;
  }
}