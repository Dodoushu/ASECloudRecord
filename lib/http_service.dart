import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'dart:async';
import 'showAlertDialogClass.dart';
//import 'Loading.dart';

Future request(url, {FormData, String contentType = 'application/json'}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = contentType;
    //
    // FormData是数据体，默认放在post中的body里
//    Navigator.push(context, DialogRouter(LoadingDialog()));
//    Loading.before('请稍候');
    response = await dio.post(url, data: FormData);

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      print('http成功');
//        Loading.complete();
      return response;
    } else {
//        Loading.complete();
      throw Exception('网络异常');
    }

  } catch (e) {
    return print(e);
  }
}