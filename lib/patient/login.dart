import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'MainFunctionPage.dart';
import 'register1.dart' as reg1;
import 'package:helloworld/showAlertDialogClass.dart';
import 'register2.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(new MaterialApp(home: new Login()));

/// 用户协议中“低调”文本的样式。
final TextStyle _lowProfileStyle = TextStyle(
  fontSize: 15.0,
  color: Color(0xFF4A4A4A),
);

/// 用户协议中“高调”文本的样式。
final TextStyle _highProfileStyle = TextStyle(
  fontSize: 15.0,
  color: Color(0xFF00CED2),
);

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;

  void login() async {
//    //演示时去掉验证功能
//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (context) => MainPage()),
//            (route) => false);

    //读取当前的Form状态

    Future.delayed(Duration(seconds: 1),(){
      Navigator.pop(context);
    });
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      var sign = Map();
      sign['phone_num'] = userName;
      sign['pass_word'] = password;
      var bodymap = Map();
      bodymap['sign'] = sign;
      var url = "http://39.100.100.198:8082/sign";
      var formData = bodymap;
      print(formData);
      await request(url, FormData: formData).then((value) {
        print('response:' + value.toString());
        Map data = json.decode(value.toString());
        print(data);
        if (data['status_code'] == 4) {
          showAlertDialog(context,
              titleText: '个人信息尚未录入', contentText: '请点击确定开始录入信息');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => register2()),
              (route) => false);
        } else if (data['status_code'] == 0) {
          SharedPreferenceUtil.setString('phoneNum', userName.toString())
              .then((value) {
            SharedPreferenceUtil.setString('name', data['name']).then((value) {
              SharedPreferenceUtil.setString('token', data['token'])
                  .then((value) {
                print(value);
                showAlertDialog(context, titleText: '', contentText: '登陆成功');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (route) => false);
              });
            });
          });
        } else if (data['status_code'] == 1 || data['status_code'] == 2) {
          showAlertDialog(context, titleText: '登陆失败', contentText: '请检查账号密码');
        } else {
          showAlertDialog(context, titleText: '登陆失败', contentText: '未知错误');
        }
      });
    }
  }

//        print('the response is:');
//        print(value);
//        var data = json.decode(value.toString());
//        print(data.toString());

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            width: double.infinity,
            height: 90,
            child: Center(
                child: new Text(
              '云病例患者端登录LOGO',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            )),
          ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
              autovalidate: true,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                        // suffixIcon: new IconButton(
                        //   icon: new Icon(
                        //     Icons.close,
                        //     color: Color.fromARGB(255, 126, 126, 126),
                        //   ),
                        //   onPressed: () {

                        //   },
                        // ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        userName = value;
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: '请输入密码',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: new IconButton(
                            icon: new Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: showPassWord,
                          )),
                      obscureText: !isShowPassWord,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(0),
                    height: 50.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: new SizedBox.expand(
                      child: new RaisedButton(
                        elevation: 20,
                        onPressed: login,
                        color: Colors.blue,
                        child: new Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                      ),
                    ),
                  ),

                  new Container(
                    //margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            '忘记密码？',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 53, 53, 53)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => reg1.Login()),
                            );
                          },
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 53, 53, 53)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Center(
                        child: Text.rich(
                          // 文字跨度（`TextSpan`）组件，不可变的文本范围。
                          TextSpan(
                            // 文本（`text`）属性，跨度中包含的文本。
                            text: '登录即同意',
                            // 样式（`style`）属性，应用于文本和子组件的样式。
                            style: _lowProfileStyle,
                            children: [
                              TextSpan(
                                // 识别（`recognizer`）属性，一个手势识别器，它将接收触及此文本范围的事件。
                                // 手势（`gestures`）库的点击手势识别器（`TapGestureRecognizer`）类，识别点击手势。
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('点击了“服务条款”');
                                  },
                                text: '“服务条款”',
                                style: _highProfileStyle,
                              ),
                              TextSpan(
                                text: '和',
                                style: _lowProfileStyle,
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('点击了“隐私政策”');
                                  },
                                text: '“隐私政策”',
                                style: _highProfileStyle,
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
