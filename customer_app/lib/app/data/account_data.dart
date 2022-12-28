import 'dart:convert';

import 'package:customer_app/app/models/model_address.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:http/http.dart' as http;

class AccountData{
  //Get list address of customer from api
  Future<List<AddressModel>> fetchCustomerAddress(cusId
      ) async{
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/customer/getAllAddress/customerId/$cusId'),
      headers: <String, String>{
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
    final response = await http.post(
      Uri.parse('${PrefData.apiUrl}/api/customer/addNewAddress'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "customerId": 2,
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
  Future<void> setDefaultAddress(cusId,addressId
      ) async{
    final response = await http.put(
        Uri.parse('${PrefData.apiUrl}/api/customer/chooseDefaultAddress/$cusId/$addressId'),
        headers: <String, String>{
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
    final response = await http.put(
      Uri.parse('${PrefData.apiUrl}/api/customer/updateAddress/adressId/$addressId'),
      headers: <String, String>{
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
    final response = await http.put(
      Uri.parse('${PrefData.apiUrl}/api/customer/deleteAddress/addressId/$addressId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }



}