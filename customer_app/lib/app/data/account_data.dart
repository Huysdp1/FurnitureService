import 'dart:convert';

import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/models/model_account.dart';
import 'package:customer_app/app/models/model_address.dart';
import 'package:customer_app/app/models/model_auth.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountData{

  //Get list address of customer from api
  Future<List<AddressModel>> fetchCustomerAddress(
      ) async{
    int cusId = await PrefData.getCusId();
     String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/customer/getAllAddress/customerId/$cusId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200){
      PrefData.setAddressModel(response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  AddressModel.fromList(parsed);
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }

  //Add new address of customer from api
  Future<AddressModel> generateNewAddress(AddressModel newAddress,
      ) async{
    int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('${PrefData.apiUrl}/api/customer/addNewAddress'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "customerId": cusId,
        "homeNumber": newAddress.homeNumber,
        "street": newAddress.street,
        "ward": newAddress.ward,
        "district": newAddress.district,
        "city": newAddress.city,
        "customerNameOrder": newAddress.customerNameOrder,
        "customerPhoneOrder": newAddress.customerPhoneOrder,
        "isDefault": false
      })
    );
    if(response.statusCode == 200){
      return AddressModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
  
  Future<void> setDefaultAddress(addressId
      ) async{
    int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
        Uri.parse('${PrefData.apiUrl}/api/customer/chooseDefaultAddress/$cusId/$addressId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
  Future<void> updateAddress(AddressModel addressModel,addressId
      ) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
      Uri.parse('${PrefData.apiUrl}/api/customer/updateAddress/adressId/$addressId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(addressModel.toJson())
    );
    if(response.statusCode == 200){
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
  Future<void> deleteAddress(addressId)async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
      Uri.parse('${PrefData.apiUrl}/api/customer/deleteAddress/addressId/$addressId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }


  Future<http.Response> loginCustomer(String username,String password) async{
    final response = await http.post(
        Uri.parse('${PrefData.apiUrl}/api/account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "password": password
        })
    );
    if(response.statusCode == 200){
      PrefData.setLogIn(true);
      PrefData.setCusId(AuthModel.fromJson(jsonDecode(response.body.toString())).userLoginBasicInformationDto!.userId!);
      const FlutterSecureStorage().write(key: 'accessToken', value: AuthModel.fromJson(jsonDecode(response.body.toString())).accessToken);
      const FlutterSecureStorage().write(key: 'refreshToken', value: AuthModel.fromJson(jsonDecode(response.body.toString())).refreshToken);
      return response;
    }else{
      return response;
    }
  }

  Future<bool> logoutCustomer(int accountId) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
        Uri.parse('${PrefData.apiUrl}/api/account/logout/accountId/$accountId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      DataFile.defaultAddress = AddressModel();
      PrefData.setLogIn(false);
      PrefData.setCusId(-1);
      const FlutterSecureStorage().deleteAll();
      return true;
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }


  Future<AccountModel> fetchCustomerInfo(
      ) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    int cusId = await PrefData.getCusId();
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/customer/getCustomerDetailById/$cusId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      PrefData.setAccountModel(response.body.toString());
      return  AccountModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }

  Future<http.Response> registerCustomer(name, username, password, phone) async{
    final response = await http.post(
        Uri.parse('${PrefData.apiUrl}/api/account/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "customerName": name,
          "customerPhone": phone,
          "username": username,
          "password": password,
          "roleId": 4,
          "createAt": DateTime.parse(DateTime.now().toString()).toString(),
          "accountStatus": true
        })
    );
    if(response.statusCode == 200){
      return response;
    }else{
      return response;
    }
  }

}