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
  String? customerNameOrder;
  String? customerPhoneOrder;
  bool? isDefault;
  bool? status;

  AddressModel({this.addressId, this.customerId, this.homeNumber, this.street, this.ward, this.district, this.city, this.customerNameOrder, this.customerPhoneOrder, this.isDefault, this.status});

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
    if(json["customerNameOrder"] is String) {
      customerNameOrder = json["customerNameOrder"];
    }
    if(json["customerPhoneOrder"] is String) {
      customerPhoneOrder = json["customerPhoneOrder"];
    }
    if(json["isDefault"] is bool) {
      isDefault = json["isDefault"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<AddressModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AddressModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(homeNumber!=null) {_data["homeNumber"] = homeNumber;}
    if(street!=null){_data["street"] = street;}
    if(ward!=null){_data["ward"] = ward;}
    if(district!=null){_data["district"] = district;}
    if(city!=null){_data["city"] = city;}
    if(customerPhoneOrder!=null){_data["customerNameOrder"] = customerNameOrder;}
    if(customerPhoneOrder!=null){_data["customerPhoneOrder"] = customerPhoneOrder;}
    return _data;
  }
  AddressModel copyWith({
    int? addressId,
    int? customerId,
    String? homeNumber,
    String? street,
    String? ward,
    String? district,
    String? city,
    String? customerNameOrder,
    String? customerPhoneOrder,
    bool? isDefault,
    bool? status,
  }) => AddressModel(
    addressId: addressId ?? this.addressId,
    customerId: customerId ?? this.customerId,
    homeNumber: homeNumber ?? this.homeNumber,
    street: street ?? this.street,
    ward: ward ?? this.ward,
    district: district ?? this.district,
    city: city ?? this.city,
    customerNameOrder: customerNameOrder ?? this.customerNameOrder,
    customerPhoneOrder: customerPhoneOrder ?? this.customerPhoneOrder,
    isDefault: isDefault ?? this.isDefault,
    status: status ?? this.status,
  );
}