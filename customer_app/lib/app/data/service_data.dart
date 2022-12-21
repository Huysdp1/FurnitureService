import 'dart:convert';

import 'package:customer_app/app/models/model_category.dart';
import 'package:customer_app/app/models/model_service.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:http/http.dart' as http;

class ServiceData{
  //Get list service  from api
  Future<List<ServiceModel>> fetchServicesAndCategories(
      ) async{
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/customer/getServiceAndCategoryInfor'),
      headers: <String, String>{
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
    final response = await http.get(
      Uri.parse('${PrefData.apiUrl}/api/category/getallcategory'),
      headers: <String, String>{
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