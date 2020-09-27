import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'dart:async';
import 'showAlertDialogClass.dart';
//import 'Loading.dart';

Future request(url, {FormData, String contentType = 'application/json'}) async {
  var response;
  var map = {'flag':1,'response':response,'ErrorContent':null};
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = contentType;

    // FormData是数据体，默认放在post中的body里
    // Navigator.push(context, DialogRouter(LoadingDialog()));
    // Loading.before('请稍候');
    response = await dio.post(url, data: FormData);

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      print('http成功');
    //        Loading.complete();

      return map;
    } else {
    //        Loading.complete();
      throw Exception('网络异常');
    }

  } catch (e) {
    map['flag'] = 0;
    map['ErrorContent'] = e;
    return map;
  }
}
String formatError(DioError e) {
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    // It occurs when url is opened timeout.
    print("连接超时");
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    // It occurs when url is sent timeout.
    print("请求超时");
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    //It occurs when receiving timeout
    print("响应超时");
  } else if (e.type == DioErrorType.RESPONSE) {
    // When the server response, but with a incorrect status, such as 404, 503...
    print("出现异常");
  } else if (e.type == DioErrorType.CANCEL) {
    // When the request is cancelled, dio will throw a error with this type.
    print("请求取消");
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    print("未知错误");
  }
}