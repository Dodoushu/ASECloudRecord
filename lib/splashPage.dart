//import 'package:flutter/material.dart';
//
//// Description:闪屏
//
//
//class SplashPage extends StatefulWidget {
//  @override
//  _SplashState createState() => new _SplashState();
//}
//
//class _SplashState extends State<SplashPage> {
//  @override
//  void initState() {
//    new Future.delayed(Duration(seconds: 2), () {
//      print("HD钱包启动...");
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Container(
//      child: Image.asset("images/splashLogo.jpg", fit: BoxFit.cover),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'select.dart';
import 'patient/MainFunctionPage.dart' as patientMain;
import 'doctor/MainFunctionPage.dart' as doctorMain;
import 'showAlertDialogClass.dart';
import 'package:flutter/services.dart';

import 'package:helloworld/select.dart';
//import 'package:flutter_demo/view/HomePage.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPage createState() => new _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  //flag
  bool isStartHomePage = false;

//页面初始化状态的方法
  @override
  void initState() {
    print('initState');
    super.initState();
    //开启倒计时
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 1);
    print('countdown');
    new Future.delayed(duration, (){
      SharedPreferenceUtil.containsKey('lisence').then((value){
        if(value==false){
          UserLicense(context);
          print('1');
        }
        else if(value==true){
          print('2');
          goToHomePage();
        }
      });
    });
  }

  UserLicense(BuildContext context, {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定', flag: 0}) {

    //设置按钮
    Widget agree = FlatButton(
      child: Text('同意'),
      onPressed: () {
        SharedPreferenceUtil.setString('lisence', '1').then((value){
          goToHomePage();
        });
      },
    );

    //设置按钮
    Widget disagree = FlatButton(
      child: Text('不同意'),
      onPressed: () async {
        SystemNavigator.pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text('用户协议'),
      content: Text('协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容'),
      actions: [
        agree,
        disagree
      ],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void goToHomePage() {
    print('gotohomepage');
    SharedPreferenceUtil.containsKey('token').then((value) {
      print(value);
      if (value == false) {
        print('value == false');
        isStartHomePage = true;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => select()),
            (route) => false);
      } else {
        print('else');
        String token;
        Future<bool> result =
            SharedPreferenceUtil.getString('token').then((value) {
          token = value;
          String phoneNum;
          print('token存在');
          SharedPreferenceUtil.getString('phoneNum').then((value) {
            phoneNum = value;
            var sign = Map();
            var bodymap = Map();
//          sign['phone_num']=phoneNum;
//          bodymap['token']=token;
//          bodymap['sign']=sign;
            sign['phone_num'] = phoneNum;
            bodymap['token'] = token;
            bodymap['sign'] = sign;
            print(bodymap);
            String url = 'http://39.100.100.198:8082/sign';
            var result;
            request(url, FormData: bodymap).then((value) {
              result = json.decode(value.toString());
              print(result);

              //token不合法
              if (result['status_code'] == 3) {
                SharedPreferenceUtil.remove('token').then((value) {
                  isStartHomePage = true;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => select()),
                      (route) => false);
                });
              }

              //token合法
              if (result['status_code'] == 0) {
                if (result['user_type'] == 0) {
                  print('0---0');
                  isStartHomePage = true;
                  SharedPreferenceUtil.setString('name', result['name'])
                      .then((value) {
                    print('0---0');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => select()),
                            (route) => false);
                  });
                } else if (result['user_type'] == 3) {
                  print('0---1');
                  isStartHomePage = true;
                  SharedPreferenceUtil.setString('name', result['name'])
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctorMain.MainPage()),
                        (route) => false);
                  });
                }
                ;
              }
            });
          });
        });
      }
    });

    //如果页面还未跳转过则跳转至选择页面
    if (!isStartHomePage) {
      //跳转至身份选择页面 且销毁当前页面
//      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new select()), (Route<dynamic> rout)=>false);
      isStartHomePage = true;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => select()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new GestureDetector(
//      onTap: goToHomePage,//设置页面点击事件
      child: Image.asset(
        "images/splashLogo.png",
        fit: BoxFit.cover,
      ), //此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
    ));
  }
}
