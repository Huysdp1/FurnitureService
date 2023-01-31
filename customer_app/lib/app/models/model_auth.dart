
class AuthModel {
  String? accessToken;
  String? refreshToken;
  UserLoginBasicInformationDto? userLoginBasicInformationDto;

  AuthModel({this.accessToken, this.refreshToken, this.userLoginBasicInformationDto});

  AuthModel.fromJson(Map<String, dynamic> json) {
    if(json["accessToken"] is String) {
      accessToken = json["accessToken"];
    }
    if(json["refreshToken"] is String) {
      refreshToken = json["refreshToken"];
    }
    if(json["userLoginBasicInformationDto"] is Map) {
      userLoginBasicInformationDto = json["userLoginBasicInformationDto"] == null ? null : UserLoginBasicInformationDto.fromJson(json["userLoginBasicInformationDto"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["accessToken"] = accessToken;
    data["refreshToken"] = refreshToken;
    if(userLoginBasicInformationDto != null) {
      data["userLoginBasicInformationDto"] = userLoginBasicInformationDto?.toJson();
    }
    return data;
  }
}

class UserLoginBasicInformationDto {
  int? accountId;
  int? userId;
  String? fullUserName;
  String? userPhone;
  String? roleName;
  String? usernameLogin;

  UserLoginBasicInformationDto({this.accountId, this.userId, this.fullUserName, this.userPhone, this.roleName, this.usernameLogin});

  UserLoginBasicInformationDto.fromJson(Map<String, dynamic> json) {
    if(json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if(json["userId"] is int) {
      userId = json["userId"];
    }
    if(json["fullUserName"] is String) {
      fullUserName = json["fullUserName"];
    }
    if(json["userPhone"] is String) {
      userPhone = json["userPhone"];
    }
    if(json["roleName"] is String) {
      roleName = json["roleName"];
    }
    if(json["usernameLogin"] is String) {
      usernameLogin = json["usernameLogin"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["accountId"] = accountId;
    data["userId"] = userId;
    data["fullUserName"] = fullUserName;
    data["userPhone"] = userPhone;
    data["roleName"] = roleName;
    data["usernameLogin"] = usernameLogin;
    return data;
  }
}


class RegisterModel {
  String? customerName;
  String? customerPhone;
  String? username;
  String? password;
  int? roleId;
  String? createAt;
  bool? accountStatus;

  RegisterModel({this.customerName, this.customerPhone, this.username, this.password, this.roleId, this.createAt, this.accountStatus});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    if(json["customerName"] is String) {
      customerName = json["customerName"];
    }
    if(json["customerPhone"] is String) {
      customerPhone = json["customerPhone"];
    }
    if(json["username"] is String) {
      username = json["username"];
    }
    if(json["password"] is String) {
      password = json["password"];
    }
    if(json["roleId"] is int) {
      roleId = json["roleId"];
    }
    if(json["createAt"] is String) {
      createAt = json["createAt"];
    }
    if(json["accountStatus"] is bool) {
      accountStatus = json["accountStatus"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customerName"] = customerName;
    data["customerPhone"] = customerPhone;
    data["username"] = username;
    data["password"] = password;
    data["roleId"] = roleId;
    data["createAt"] = createAt;
    data["accountStatus"] = accountStatus;
    return data;
  }
}



class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? updateAt;

  ChangePasswordModel({this.oldPassword, this.newPassword, this.updateAt});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    if(json["oldPassword"] is String) {
      oldPassword = json["oldPassword"];
    }
    if(json["newPassword"] is String) {
      newPassword = json["newPassword"];
    }
    if(json["updateAt"] is String) {
      updateAt = json["updateAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["oldPassword"] = oldPassword;
    data["newPassword"] = newPassword;
    data["updateAt"] = updateAt;
    return data;
  }
}