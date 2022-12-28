class AddressAuto {
  String? level1Id;
  String? name;
  String? type;
  List<Level2S>? level2S;

  AddressAuto({this.level1Id, this.name, this.type, this.level2S});

  AddressAuto.fromJson(Map<String, dynamic> json) {
    if (json["level1_id"] is String) {
      level1Id = json["level1_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["level2s"] is List) {
      level2S = json["level2s"] == null
          ? null
          : (json["level2s"] as List).map((e) => Level2S.fromJson(e)).toList();
    }
  }

  static List<AddressAuto> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AddressAuto.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["level1_id"] = level1Id;
    data["name"] = name;
    data["type"] = type;
    if (level2S != null) {
      data["level2s"] = level2S?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  AddressAuto copyWith({
    String? level1Id,
    String? name,
    String? type,
    List<Level2S>? level2S,
  }) =>
      AddressAuto(
        level1Id: level1Id ?? this.level1Id,
        name: name ?? this.name,
        type: type ?? this.type,
        level2S: level2S ?? this.level2S,
      );
}

class Level2S {
  String? level2Id;
  String? name;
  String? type;
  List<Level3S>? level3S;

  Level2S({this.level2Id, this.name, this.type, this.level3S});

  Level2S.fromJson(Map<String, dynamic> json) {
    if (json["level2_id"] is String) {
      level2Id = json["level2_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["level3s"] is List) {
      level3S = json["level3s"] == null
          ? null
          : (json["level3s"] as List).map((e) => Level3S.fromJson(e)).toList();
    }
  }

  static List<Level2S> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Level2S.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["level2_id"] = level2Id;
    data["name"] = name;
    data["type"] = type;
    if (level3S != null) {
      data["level3s"] = level3S?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  Level2S copyWith({
    String? level2Id,
    String? name,
    String? type,
    List<Level3S>? level3S,
  }) =>
      Level2S(
        level2Id: level2Id ?? this.level2Id,
        name: name ?? this.name,
        type: type ?? this.type,
        level3S: level3S ?? this.level3S,
      );
}

class Level3S {
  String? level3Id;
  String? name;
  String? type;

  Level3S({this.level3Id, this.name, this.type});

  Level3S.fromJson(Map<String, dynamic> json) {
    if (json["level3_id"] is String) {
      level3Id = json["level3_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
  }

  static List<Level3S> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Level3S.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["level3_id"] = level3Id;
    data["name"] = name;
    data["type"] = type;
    return data;
  }

  Level3S copyWith({
    String? level3Id,
    String? name,
    String? type,
  }) =>
      Level3S(
        level3Id: level3Id ?? this.level3Id,
        name: name ?? this.name,
        type: type ?? this.type,
      );
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if(homeNumber!=null) {data["homeNumber"] = homeNumber;}
    if(street!=null){data["street"] = street;}
    if(ward!=null){data["ward"] = ward;}
    if(district!=null){data["district"] = district;}
    if(city!=null){data["city"] = city;}
    if(customerPhoneOrder!=null){data["customerNameOrder"] = customerNameOrder;}
    if(customerPhoneOrder!=null){data["customerPhoneOrder"] = customerPhoneOrder;}
    return data;
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