import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'dart:async';

Future request(url, {formData}) async{
  try{
    Response response;
    Dio dio = Dio();
    response = await dio.post(url, data: formData);
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception('后端接口异常');
    }
  }catch (e) {
    return print('error:::${e}');
  }
}

var url = "http://101.133.228.14:8081/config?";