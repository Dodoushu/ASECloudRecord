import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'dart:async';

Future request(url, {FormData}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = 'application/json';

    response = await dio.post(url, data: FormData);

    if (response.statusCode == 200) {
      print('http成功');
      return response;
    } else {
      throw Exception('http失败');
    }
  } catch (e) {
    return print(e);
  }
}
