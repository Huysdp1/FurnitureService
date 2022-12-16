import 'dart:convert';

import 'package:customer_app/app/models/model_cart.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:http/http.dart' as http;

class OrderData{
  //create order  from api
  Future<void> createOrderCustomer(cusId,CartModel fromCart
      ) async{
    final response = await http.post(
      Uri.parse('${PrefData.apiUrl}/api/customer/createOrder/customer/$cusId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(fromCart.toJson())
    );
    if(response.statusCode == 200){
      print(response.body);
    }else{
      throw Exception(response.body.toString());
    }
  }
}