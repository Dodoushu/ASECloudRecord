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
import 'login.dart';
import 'package:helloworld/select.dart';

//import 'package:flutter_demo/view/HomePage.dart';
import 'patient/BottomNavigationBar.dart';

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
    super.initState();
    //开启倒计时
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 1);
    new Future.delayed(duration, () {
      SharedPreferenceUtil.containsKey('lisence').then((value) {
        if (value == false) {
          UserLicense(context);
          print('1');
        } else if (value == true) {
          print('2');
          goToHomePage(context);
        }
      });
    });
  }

  UserLicense(BuildContext context,
      {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定', flag: 0}) {
    //设置按钮
    Widget agree = FlatButton(
      child: Text('同意'),
      onPressed: () {
        SharedPreferenceUtil.setString('lisence', '1').then((value) {
          goToHomePage(context);
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
      actions: [agree, disagree],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void goToHomePage(BuildContext context) {
    print('gotohomepage');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
            (route) => false);

    //如果页面还未跳转过则跳转至选择页面
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
