import 'dart:convert';

import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/models/model_cart.dart';
import 'package:customer_app/app/models/model_order_detail.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/model_order.dart';

class OrderData{
  //create order  from api
  Future<void> createOrderCustomer(CartModel fromCart
      ) async{
    int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('${PrefData.apiUrl}/api/customer/createOrder/customer/$cusId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(fromCart.toJson())
    );
    if(response.statusCode == 200){
    }else{
      throw Exception(response.body.toString());
    }
  }

  //Get list customer's orders from api
  Future<List<OrderModel>> fetchOrdersOfCustomer() async{
    int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.get(
        Uri.parse('${PrefData.apiUrl}/api/customer/getListOrderByCustomerId/$cusId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if(response.statusCode == 200){
      PrefData.setOrderModel(response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  OrderModel.fromList(parsed);
    }else{
      throw Exception(response.body.toString());
    }
  }
  Future<OrderDetail> fetchOrderDetail(orderId) async{
    //int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.get(
        Uri.parse('${PrefData.apiUrl}/api/customer/getOrderInformation/orderId/$orderId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if(response.statusCode == 200){
      final parsed = json.decode(response.body);
      DataFile.orderDetailObj = OrderDetail.fromJson(parsed);
      return  OrderDetail.fromJson(parsed);
    }else{
      throw Exception(response.body.toString());
    }
  }
  Future<OrderModel> updateOrderCustomer(CartModel fromCart,orderId
      ) async{
    int cusId = await PrefData.getCusId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
        Uri.parse('${PrefData.apiUrl}/api/customer/updateOrder/orderId/$orderId/customerId/$cusId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(fromCart.toUpdateJson())
    );
    if(response.statusCode == 200){
      return OrderModel.fromJson(json.decode(response.body));
    }else{
      throw Exception(response.body.toString());
    }
  }
  Future<void> deleteOrderCustomer(orderId,orderServiceId) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.delete(
        Uri.parse('${PrefData.apiUrl}/api/customer/deleteServiceInOrder/$orderId/orderServiceId/$orderServiceId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
    }else{
      throw Exception(response.body.toString());
    }
  }

  Future<bool> updateOrderStatus(orderId,statusReq
      ) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
        Uri.parse('${PrefData.apiUrl}/api/customer/update_order_status_by_id/$orderId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'statusId': statusReq,
          }
        )
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}