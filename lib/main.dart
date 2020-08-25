import 'package:flutter/material.dart';
import 'splashPage.dart';
import 'select.dart';
import 'doctor/login.dart' as doctorLogin;
import 'patient/login.dart' as patientLogin;
import 'patient/MainFunctionPage.dart' as patientMain;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'FlutterDemo',
//        routes: <String,WidgetBuilder>{//配置路径
//          '/select':(BuildContext context)  => new select(),
//          '/patientLogin':(BuildContext context) => new doctorLogin.Login(),
//          '/doctorLogin':(BuildContext context) => new patientLogin.Login(),
//          '/patient/MainFunctionPage':(BuildContext context) => new patientMain.MainPage(),
//        },
//        theme: new ThemeData(
//          // This is the theme of your application.
//          //
//          // Try running your application with "flutter run". You'll see the
//          // application has a blue toolbar. Then, without quitting the app, try
//          // changing the primarySwatch below to Colors.green and then invoke
//          // "hot reload" (press "r" in the console where you ran "flutter run",
//          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//          // counter didn't reset back to zero; the application is not restarted.
//          primarySwatch: Colors.blue,
//        ),
        theme: ThemeData(
          //主题色
          primaryColor:Colors.white,
        ),
        //当手机处于夜间模式时，优先执行darkTheme
        darkTheme: ThemeData(
          primaryColor:Colors.black,
        ),
        home: new SplashPage()
    );
  }
}
