import 'dart:convert';

import 'package:customer_app/app/models/model_category.dart';
import 'package:customer_app/app/models/model_service.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceData{
  static const storage = FlutterSecureStorage();
  //Get list service  from api
  Future<List<ServiceModel>> fetchServicesAndCategories(id
      ) async{
    String token = const FlutterSecureStorage().read(key: 'accessToken').toString();
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/manager/getAllServiceByCategory/categoryId/$id'),
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  ServiceModel.fromList(parsed);
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
  Future<List<CategoryModel>> fetchCategories() async{
    String token = const FlutterSecureStorage().read(key: 'accessToken').toString();
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/category/getallcategory'),
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      PrefData.setCategoryModel(response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return  CategoryModel.fromList(parsed);
    }else{
      throw Exception('Lấy dữ liệu thất bại');
    }
  }
}