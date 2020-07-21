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

import 'package:helloworld/select.dart';
//import 'package:flutter_demo/view/HomePage.dart';

class SplashPage extends StatefulWidget{

  SplashPage({Key key}):super(key:key);
  @override
  _SplashPage createState()=> new _SplashPage();

}

class _SplashPage extends State<SplashPage>{

  bool isStartHomePage = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
//      onTap: goToHomePage,//设置页面点击事件
      child: Image.asset("images/splashLogo.jpg",fit: BoxFit.cover,),//此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
    );
}

//页面初始化状态的方法
@override
void initState() {
  super.initState();
  //开启倒计时
  countDown();
}

void countDown() {
  //设置倒计时三秒后执行跳转方法
  var duration = new Duration(seconds: 3);
  new Future.delayed(duration, goToHomePage);
}

void goToHomePage(){
  //如果页面还未跳转过则跳转页面
  if(!isStartHomePage){
    //跳转至身份选择页面 且销毁当前页面
//      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new select()), (Route<dynamic> rout)=>false);
    Navigator.pushNamedAndRemoveUntil(context, '/select', (Route<dynamic> rout)=>false);
    isStartHomePage=true;
  }
}
}
