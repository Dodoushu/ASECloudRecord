import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'dart:async';

Future request(url, BuildContext context, {FormData, String contentType = 'application/json'}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = contentType;
    // FormData是数据体，默认放在post中的body里
    // Navigator.push(context, DialogRouter(LoadingDialog()));
    // Loading.before('请稍候');
    print("################################################");
    response = await dio.post(url, data: FormData);
    print('************************************************');
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      print('http成功');
      //        Loading.complete();
      return response;
    } else {
      //        Loading.complete();
      //throw Exception('网络异常');
    }

  } catch (e) {
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    showAlertDialog(context, titleText: '请求失败', contentText: '请稍后重试',flag: 1);  //失败，点击退出失败提示弹窗和loading动画
//    return 0;
  }
}