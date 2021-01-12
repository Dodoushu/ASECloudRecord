import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:flutter/gestures.dart';
import 'package:helloworld/patient/BottomNavigationBar.dart';
import 'doctor/MainFunctionPage.dart';
import 'package:helloworld/patient/register2.dart' as patient_register2;
import 'package:helloworld/doctor/register2.dart' as doctor_register2;
import 'package:helloworld/select.dart' as register_select;
import 'package:helloworld/doctor/BottomNavigationBar.dart' as doctorBottom;

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

  bool ishavephoneNumber = false;
  String prePhoneNumber;
  bool ifremeberpwd = false;
  bool remberPwd = false;

  List<bool> select = [true, false];

  TextEditingController _controller = new TextEditingController();
  TextEditingController _pwdcontroller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //开启倒计时
    SharedPreferenceUtil.containsKey('prePhoneNumber').then((value) {
      ishavephoneNumber = value;
        SharedPreferenceUtil.getBool('ifRemberPwd').then((value){
          ifremeberpwd = value;
          if(ishavephoneNumber == true){
            SharedPreferenceUtil.getString('prePhoneNumber').then((value) {
              prePhoneNumber = value;
              if(ifremeberpwd == false){
                setState(() {
                  userName = prePhoneNumber;
                  _controller.text = prePhoneNumber;
                  remberPwd = false;
                });
              }else {
                SharedPreferenceUtil.getString('prePwd').then((value){
                  setState(() {
                    userName = prePhoneNumber;
                    _controller.text = prePhoneNumber;
                    password = value;
                    _pwdcontroller.text = value;
                    remberPwd = true;
                  });
                });
              }
            });
          }
        });
    });
  }

  showAlertDialog_register2_patient(
      {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定'}) {
    //设置按钮
    Widget okButton = FlatButton(
      child: Text(bottonText),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => patient_register2.register2()),
                (route) => false);
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        okButton,
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

  showAlertDialog_register2_doctor(
      {titleText: '请设置标题', contentText: '请设置内容', bottonText: '确定'}) {
    //设置按钮
    Widget okButton = FlatButton(
      child: Text(bottonText),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => doctor_register2.register2()),
                (route) => false);
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        okButton,
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

  void login() async {
//    //演示时去掉验证功能
//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (context) => MainPage()),
//            (route) => false);

    //读取当前的Form状态

//    Future.delayed(Duration(seconds: 1),(){
//      Navigator.pop(context);
//    });
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      var sign = Map();
      sign['phone_num'] = userName;
      sign['pass_word'] = password;
      if (select[0] == true) {
        sign['user_type'] = '0';
      }
      if (select[1] == true) {
        sign['user_type'] = '1';
      }
      var bodymap = Map();
      bodymap['sign'] = sign;
      var url = "http://39.100.100.198:8082/sign";
      var formData = bodymap;
      print(formData);
      await request(url, context, FormData: formData).then((value) {
        Map data = json.decode(value.toString());
        print(data);
        //登陆成功
        SharedPreferenceUtil.setString('userId', data['userId'].toString())
            .then((value) {
          SharedPreferenceUtil.setString('prePhoneNumber', userName.toString())
              .then((value) {
            SharedPreferenceUtil.setString('phoneNum', userName.toString())
                .then((value) {
              SharedPreferenceUtil.setString('name', data['name'])
                  .then((value) {
                SharedPreferenceUtil.setString('prePwd', password)
                    .then((value) {
                  SharedPreferenceUtil.setBool('ifRemberPwd', remberPwd).then((value){
                    print(value);
                    if (sign['user_type'] == '0') {
                      if (data['status_code'] == 4) {
                        showAlertDialog_register2_patient(
                            titleText: '个人信息尚未录入', contentText: '请点击确定开始录入信息');
                      } else if (data['status_code'] == 0) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget()),
                                (route) => false);
                      }else {
                        showAlertDialog(context, titleText: '登陆失败', contentText: '请检查用户名密码以及登陆身份',flag: 0);
                      }
                    }
                    if (sign['user_type'] == '1') {
                      if (data['status_code'] == 4) {
                        showAlertDialog_register2_doctor(
                            titleText: '个人信息尚未录入', contentText: '请点击确定开始录入信息');
                      } else if (data['status_code'] == 0) {
                        SharedPreferenceUtil.setString('doctorUserId', data['doctor']['id'].toString()).then((value){
                          SharedPreferenceUtil.setString('doctorName', data['doctor']['name'].toString()).then((value){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
                          });
                        });
                      }else {
                        showAlertDialog(context, titleText: '登陆失败', contentText: '请检查用户名密码以及登陆身份',flag: 0);
                      }
                    }
                  });
                });
              });
            });
          });
        });
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
              '云病例登录LOGO',
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
                      controller: _controller,
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
                      controller: _pwdcontroller,
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
                  SizedBox(
                    height: 10,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            select[0] = true;
                            select[1] = false;
                          });
                        },
                        child: new Row(
                          children: [
                            Checkbox(
                              value: select[0],
                            ),
                            Text('患者登录')
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            select[0] = false;
                            select[1] = true;
                          });
                        },
                        child: new Row(
                          children: [
                            Checkbox(
                              value: select[1],
                            ),
                            Text('医生登录')
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            remberPwd = !remberPwd;
                          });
                        },
                        child: new Row(
                          children: [
                            Checkbox(
                              value: remberPwd,
                            ),
                            Text('记住密码')
                          ],
                        ),
                      )
                    ],
                  ),
                  new Container(
                    padding: EdgeInsets.all(0),
                    height: 50.0,
                    margin: EdgeInsets.only(top: 10.0),
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
                                  builder: (context) => register_select.select()),
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
